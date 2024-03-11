import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_constants/local_keys.dart';
import '../../../../core/app_constants/strings.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLang({required String langCode});
  Future<String> getSavedLang();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> changeLang({required String langCode}) async =>
      await sharedPreferences.setString(AppLocalKey.langKey, langCode);

  @override
  Future<String> getSavedLang() async =>
      sharedPreferences.containsKey(AppLocalKey.langKey)
          ? sharedPreferences.getString(AppLocalKey.langKey)!
          : AppStrings.englishCode;
}
