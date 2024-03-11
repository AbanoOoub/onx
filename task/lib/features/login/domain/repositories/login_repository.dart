import 'package:dartz/dartz.dart';
import 'package:task/core/error/failures.dart';
import 'package:task/features/login/domain/entities/login_entity.dart';

import '../use_cases/login_uc.dart';

abstract class LoginRepository{
  Future<Either<Failure,LoginEntity>> login(LoginParams params);
}