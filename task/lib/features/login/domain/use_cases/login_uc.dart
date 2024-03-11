import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/core/usecases/usecase.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import 'package:task/features/login/domain/repositories/login_repository.dart';

class LoginUC implements UseCase<LoginEntity, LoginParams> {
  final LoginRepository repository;

  LoginUC({required this.repository});

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    return repository.login(params);
  }
}

class LoginParams {
  final String pLangNO;
  final String pDlvryNO;
  final String pPsswrd;

  LoginParams(
      {required this.pLangNO, required this.pDlvryNO, required this.pPsswrd});
}
