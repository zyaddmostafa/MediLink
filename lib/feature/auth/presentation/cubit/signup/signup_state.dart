part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final SignupResponse signupResponse;
  SignupSuccess(this.signupResponse);
}

final class SignupError extends SignupState {
  final ApiErrorModel apiErrorModel;
  SignupError(this.apiErrorModel);
}
