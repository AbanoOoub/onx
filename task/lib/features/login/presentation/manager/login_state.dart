part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String msg;

  LoginErrorState({required this.msg});
}

class LoginSuccessState extends LoginState {
  final LoginEntity loginEntity;

  LoginSuccessState({required this.loginEntity});
}

class LoginFailedState extends LoginState {
  final LoginEntity loginEntity;

  LoginFailedState({required this.loginEntity});
}
