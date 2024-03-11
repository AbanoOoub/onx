import 'package:task/core/api/api_consumer.dart';
import 'package:task/core/api/end_points.dart';
import 'package:task/features/login/domain/use_cases/login_uc.dart';

import '../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel> login(LoginParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer apiConsumer;

  LoginRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<LoginModel> login(LoginParams params) async {
    final response = await apiConsumer.post(EndPoints.login, body: {
      "Value": {
        "P_LANG_NO": params.pLangNO,
        "P_DLVRY_NO": params.pDlvryNO,
        "P_PSSWRD": params.pPsswrd
      }
    });
    return LoginModel.fromJson(response);
  }
}
