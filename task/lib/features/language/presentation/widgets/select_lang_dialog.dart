import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/core/app_constants/strings.dart';
import 'package:task/core/utils/app_colors.dart';
import 'package:task/features/language/presentation/manager/language_cubit.dart';

import '../../../../core/utils/app_images.dart';
import '../../../../shared_widgets/buttons/outline_btn_widget.dart';
import '../../../../shared_widgets/custom_text.dart';
import 'language_section_widget.dart';
import 'package:task/injection_container.dart' as di;

class SelectLangDialogWidget extends StatelessWidget {
  const SelectLangDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<LanguageCubit>()..getSavedLang(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          LanguageCubit languageCubit = LanguageCubit.get(context);
          return AlertDialog(
            insetPadding: EdgeInsets.all(15.w),
            content: SizedBox(
              height: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextWidget(
                        text: 'Choose Language',
                        textStyle: Theme.of(context).textTheme.displayMedium),
                  ),
                  if (state is ChangeLangState) ...[
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              languageCubit.selectLang(AppStrings.arabicCode);
                            },
                            child: LanguageSectionWidget(
                                isSelectedLang:
                                    state.langCode == AppStrings.arabicCode,
                                langTitle: 'العربية',
                                langSubTitle: 'Arabic',
                                langImg: AppImages.arabicFlagImg),
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: () {
                              languageCubit.selectLang(AppStrings.englishCode);
                            },
                            child: LanguageSectionWidget(
                                isSelectedLang:
                                    state.langCode == AppStrings.englishCode,
                                langTitle: 'English',
                                langSubTitle: 'English',
                                langImg: AppImages.englishFlagImg),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.mainColor),
                    ),
                  ]
                ],
              ),
            ),
            actions: [
              CustomOutlineButtonWidget(
                  btnWidth: double.infinity,
                  btnHeight: 45.w,
                  text: 'Apply',
                  onPressed: () {
                    languageCubit
                        .changeLang(languageCubit.currentLangCode)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  }),
            ],
          );
        },
      ),
    );
  }
}
