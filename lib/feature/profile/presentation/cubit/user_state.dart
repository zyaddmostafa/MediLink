part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final UserInformation user;

  UserSuccess(this.user);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}

final class UserUpdateLoading extends UserState {}

final class UserUpdateSuccess extends UserState {
  final UserInformation user;

  UserUpdateSuccess(this.user);
}

final class UserUpdateError extends UserState {
  final String message;

  UserUpdateError(this.message);
}
