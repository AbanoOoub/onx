import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/app_constants/strings.dart';
import 'package:task/features/language/presentation/manager/language_cubit.dart';
import 'package:task/config/routes/app_routes.dart';
import 'package:task/core/app_constants/local_keys.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/core/utils/app_images.dart';
import 'package:task/features/language/presentation/widgets/select_lang_dialog.dart';
import 'package:task/features/login/presentation/manager/login_cubit.dart';
import 'package:task/shared_widgets/custom_text.dart';
import 'package:task/shared_widgets/buttons/custom_text_btn.dart';
import 'package:task/shared_widgets/custom_text_form_field.dart';
import '../../../../core/app_constants/arg_keys.dart';
import '../../../../core/validations/app_validation.dart';
import '../../../../shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:task/injection_container.dart' as di;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            di.sl<SharedPreferences>().setString(
                AppLocalKey.userNameKey, state.loginEntity.data.deliveryName!);
            di.sl<SharedPreferences>().setString(AppLocalKey.userNumberKey,
                LoginCubit.get(context).userIdController.text);
            di.sl<SharedPreferences>().setBool(AppLocalKey.isLoggedInKey, true);
            Navigator.pushReplacementNamed(context, AppRoutes.ordersScreen);
          }
          if (state is LoginFailedState) {
            Fluttertoast.showToast(msg: state.loginEntity.result.errMsg);
          }
          if (state is LoginErrorState) {
            Navigator.pushNamed(context, AppRoutes.errorScreen,
                arguments: {AppArgKeys.errScreenMsgKey: state.msg});
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: AppImages.showImg(
                            imgPath: AppImages.appLogoImg,
                            width: 170.w,
                            height: 75.w),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          AppImages.showImg(
                              imgPath: AppImages.redCircleImg,
                              width: 120.w,
                              height: 120.w),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const SelectLangDialogWidget();
                                },
                              );
                            },
                            child: AppImages.showImg(
                                imgPath: AppImages.languageImg,
                                width: 28.w,
                                height: 28.w),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 120.w, 20.w, 20.w),
                    child: Form(
                      key: loginCubit.formKey,
                      child: Column(
                        children: [
                          CustomTextWidget(
                              text: 'Welcome Back!',
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge),
                          CustomTextWidget(
                              text: 'Log back into your account',
                              textStyle:
                                  Theme.of(context).textTheme.displaySmall),
                          SizedBox(height: 45.w),
                          CustomTextFormFieldWidget(
                            controller: loginCubit.userIdController,
                            hint: 'UserID',
                            hintColor: AppColors.hintColor,
                            fillColor: AppColors.secondColor,
                            textInputType: TextInputType.number,
                            withBorders: false,
                            textColor: AppColors.mainTextColor,
                            validator: (value) =>
                                AppValidator.userIdValidation(value),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.w),
                          CustomTextFormFieldWidget(
                            controller: loginCubit.passwordController,
                            hint: 'Password',
                            hintColor: AppColors.hintColor,
                            fillColor: AppColors.secondColor,
                            textInputType: TextInputType.visiblePassword,
                            withBorders: false,
                            obscureText: true,
                            textColor: AppColors.mainTextColor,
                            validator: (value) =>
                                AppValidator.passwordValidation(value),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomTextButtonWidget(
                                btnWidth: 100.w,
                                btnHeight: 45.w,
                                text: 'Show More',
                                onPressed: () {},
                              )
                            ],
                          ),
                          SizedBox(height: 15.w),
                          state is LoginLoadingState
                              ? Center(
                                  child: CircularProgressIndicator.adaptive(
                                      backgroundColor: AppColors.mainColor),
                                )
                              : CustomElevatedButtonWidget(
                                  btnWidth: double.infinity,
                                  btnHeight: 45.w,
                                  text: 'Log in',
                                  onPressed: () {
                                    if (loginCubit.formKey.currentState!
                                        .validate()) {
                                      final String? lang = di
                                          .sl<SharedPreferences>()
                                          .getString(AppLocalKey.langKey);
                                      if (lang == null) {
                                        di
                                            .sl<LanguageCubit>()
                                            .changeLang(AppStrings.englishCode);
                                      }
                                      loginCubit.login();
                                    }
                                  },
                                ),
                          SizedBox(height: 40.w),
                          AppImages.showImg(
                              imgPath: AppImages.deliveryImg,
                              width: 200.w,
                              height: 170.w),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
