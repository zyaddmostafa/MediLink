part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomeCubitInitial extends HomeState {}

final class AllDoctorsLoading extends HomeState {}

final class AllDoctorsSuccess extends HomeState {
  final List<DoctorModel> doctors;

  AllDoctorsSuccess(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

final class AllDoctorsError extends HomeState {
  final ApiErrorModel error;

  AllDoctorsError(this.error);

  @override
  List<Object?> get props => [error];
}

final class SearchDoctorsLoading extends HomeState {}

final class SearchDoctorsSuccess extends HomeState {
  final List<DoctorModel> doctors;

  SearchDoctorsSuccess(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

final class SearchDoctorsError extends HomeState {
  final ApiErrorModel error;

  SearchDoctorsError(this.error);

  @override
  List<Object?> get props => [error];
}

final class SearchDoctorsClear extends HomeState {}

final class DoctorsByCategoryLoading extends HomeState {}

final class DoctorsByCategorySuccess extends HomeState {
  final List<DoctorModel> doctors;

  DoctorsByCategorySuccess(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

final class DoctorsByCategoryError extends HomeState {
  final ApiErrorModel error;

  DoctorsByCategoryError(this.error);

  @override
  List<Object?> get props => [error];
}

final class DoctorByIdLoading extends HomeState {}

final class DoctorByIdSuccess extends HomeState {
  final DoctorModel? doctor;

  DoctorByIdSuccess(this.doctor);

  @override
  List<Object?> get props => [doctor];
}

final class DoctorByIdError extends HomeState {
  final ApiErrorModel error;

  DoctorByIdError(this.error);

  @override
  List<Object?> get props => [error];
}
