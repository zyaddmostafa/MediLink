part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class SignupLoading extends AuthState {}

final class SignupSuccess extends AuthState {
  final UserModel userData;
  SignupSuccess(this.userData);

  @override
  List<Object?> get props => [userData];
}

final class SignupError extends AuthState {
  final ApiErrorModel apiErrorModel;
  SignupError(this.apiErrorModel);

  @override
  List<Object?> get props => [apiErrorModel];
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserModel userData;

  LoginSuccess(this.userData);

  @override
  List<Object?> get props => [userData];
}

final class LoginError extends AuthState {
  final ApiErrorModel apiErrorModel;

  LoginError(this.apiErrorModel);

  @override
  List<Object?> get props => [apiErrorModel];
}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final ApiErrorModel apiErrorModel;

  LogoutError(this.apiErrorModel);

  @override
  List<Object?> get props => [apiErrorModel];
}
