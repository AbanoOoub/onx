import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/language/domain/use_cases/change_lang_uc.dart';

import '../../../../core/app_constants/strings.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/use_cases/get_saved_lang_uc.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final GetSavedLangUC getSavedLangUC;
  final ChangeLangUC changeLangUC;

  LanguageCubit({required this.getSavedLangUC, required this.changeLangUC})
      : super(LanguageInitial());

  static LanguageCubit get(context) => BlocProvider.of(context);

  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUC.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLangState(langCode: currentLangCode));
    });
    debugPrint('currentLangCode: $currentLangCode');
  }

  Future<void> changeLang(String langCode) async {

    final response = await changeLangUC.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLangState(langCode: currentLangCode));
    });
    debugPrint('currentLangCode: $currentLangCode');

  }

  void selectLang(String langCode) {
    if (langCode == AppStrings.englishCode) {
      currentLangCode = AppStrings.englishCode;
    } else {
      currentLangCode = AppStrings.arabicCode;
    }
    emit(ChangeLangState(langCode: currentLangCode));
    debugPrint('currentLangCode: $currentLangCode');

  }
}
