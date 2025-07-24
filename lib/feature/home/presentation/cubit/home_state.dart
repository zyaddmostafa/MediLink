part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

final class GetAllDoctorsLoading extends HomeState {}

final class GetAllDoctorsSuccess extends HomeState {
  final List<Doctor> doctors;

  GetAllDoctorsSuccess(this.doctors);
}

final class GetAllDoctorsError extends HomeState {
  final ApiErrorModel error;

  GetAllDoctorsError(this.error);
}

final class GetDoctorByIdLoading extends HomeState {}

final class GetDoctorByIdSuccess extends HomeState {
  final Doctor doctor;

  GetDoctorByIdSuccess(this.doctor);
}

final class GetDoctorByIdError extends HomeState {
  final ApiErrorModel error;

  GetDoctorByIdError(this.error);
}

final class GetDoctorsByCategoryLoading extends HomeState {}

final class GetDoctorsByCategorySuccess extends HomeState {
  final List<Doctor> doctors;

  GetDoctorsByCategorySuccess(this.doctors);
}

final class GetDoctorsByCategoryError extends HomeState {
  final ApiErrorModel error;

  GetDoctorsByCategoryError(this.error);
}
