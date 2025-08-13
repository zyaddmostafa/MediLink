part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}

final class UserUpdateLoading extends UserState {}

final class UserUpdateSuccess extends UserState {
  final UserModel user;

  UserUpdateSuccess(this.user);
}

final class UserUpdateError extends UserState {
  final String message;

  UserUpdateError(this.message);
}
