part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}

final class LoginError extends AuthState {
  final ApiErrorModel apiErrorModel;

  LoginError(this.apiErrorModel);
}

final class SignupLoading extends AuthState {}

final class SignupSuccess extends AuthState {
  final SignupResponse signupResponse;
  SignupSuccess(this.signupResponse);
}

final class SignupError extends AuthState {
  final ApiErrorModel apiErrorModel;
  SignupError(this.apiErrorModel);
}
