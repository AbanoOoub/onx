import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/core/app_constants/local_keys.dart';
import 'package:task/core/app_constants/strings.dart';
import 'package:task/core/enums/lang_code_enum.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';

import '../../domain/use_cases/login_uc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUC loginUC;
  final SharedPreferences sharedPreferences;

  LoginCubit({required this.loginUC, required this.sharedPreferences})
      : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> login() async {
    emit(LoginLoadingState());
    final String langCode = sharedPreferences.getString(AppLocalKey.langKey) ??
        LangCodeEnumHelper.getLangCodeId(code: AppStrings.englishCode)
            .toString();

    Either<Failure, LoginEntity> response = await loginUC(LoginParams(
        pLangNO: '${LangCodeEnumHelper.getLangCodeId(code: langCode)}',
        pDlvryNO: userIdController.text,
        pPsswrd: passwordController.text));

    emit(response.fold(
        (failure) => LoginErrorState(msg: failure.mapFailureToMsg(failure)),
        (loginEntity) {
      if (loginEntity.result.errMsg == 'Successful') {
        return LoginSuccessState(loginEntity: loginEntity);
      } else {
        return LoginFailedState(loginEntity: loginEntity);
      }
    }));
  }
}
