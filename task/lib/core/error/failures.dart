import 'package:equatable/equatable.dart';

import '../app_constants/strings.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];

  String mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
