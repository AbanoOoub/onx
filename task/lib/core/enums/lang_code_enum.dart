import 'package:task/core/app_constants/strings.dart';

enum LangCode { en, ar }

abstract class LangCodeEnumHelper {
  static int getLangCodeId({required String code}) {
    switch (code) {
      case AppStrings.arabicCode:
        return 1;
      default:
        return 2;
    }
  }

  static String getLangCode({required LangCode code}) {
    switch (code) {
      case LangCode.en:
        return AppStrings.englishCode;
      case LangCode.ar:
        return AppStrings.arabicCode;
    }
  }
}
