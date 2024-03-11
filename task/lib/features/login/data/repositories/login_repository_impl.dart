import 'package:dartz/dartz.dart';
import 'package:task/core/error/exceptions.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';
import 'package:task/features/login/domain/repositories/login_repository.dart';
import 'package:task/features/login/domain/use_cases/login_uc.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl(
      { required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
      try {
        final remoteResponse = await loginRemoteDataSource.login(params);
        return Right(remoteResponse);
      } on ServerException {
        return Left(ServerFailure());
      }
  }
}
