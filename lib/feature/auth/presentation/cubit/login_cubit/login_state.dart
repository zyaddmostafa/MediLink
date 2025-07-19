part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}

final class LoginError extends LoginState {
  final ApiErrorModel apiErrorModel;

  LoginError(this.apiErrorModel);
}
