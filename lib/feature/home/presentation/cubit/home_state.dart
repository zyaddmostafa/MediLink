part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

final class AllDoctorsLoading extends HomeState {}

final class AllDoctorsSuccess extends HomeState {
  final List<DoctorModel> doctors;

  AllDoctorsSuccess(this.doctors);
}

final class AllDoctorsError extends HomeState {
  final ApiErrorModel error;

  AllDoctorsError(this.error);
}

final class SearchDoctorsLoading extends HomeState {}

final class SearchDoctorsSuccess extends HomeState {
  final List<DoctorModel> doctors;

  SearchDoctorsSuccess(this.doctors);
}

final class SearchDoctorsError extends HomeState {
  final ApiErrorModel error;

  SearchDoctorsError(this.error);
}

final class DoctorsByCategoryLoading extends HomeState {}

final class DoctorsByCategorySuccess extends HomeState {
  final List<DoctorModel> doctors;

  DoctorsByCategorySuccess(this.doctors);
}

final class DoctorsByCategoryError extends HomeState {
  final ApiErrorModel error;

  DoctorsByCategoryError(this.error);
}

final class DoctorByIdLoading extends HomeState {}

final class DoctorByIdSuccess extends HomeState {
  final DoctorModel? doctor;

  DoctorByIdSuccess(this.doctor);
}

final class DoctorByIdError extends HomeState {
  final ApiErrorModel error;

  DoctorByIdError(this.error);
}
