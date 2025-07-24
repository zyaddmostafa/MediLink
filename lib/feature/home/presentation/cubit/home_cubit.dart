import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/doctors_response.dart';
import '../../data/repo/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImpl _homeRepoImpl;
  HomeCubit(this._homeRepoImpl) : super(HomeCubitInitial());

  void getAllDoctors() async {
    emit(GetAllDoctorsLoading());
    final response = await _homeRepoImpl.getAllDoctors();
    log('Response: $response', name: 'HomeCubit');

    response.when(
      onSuccess: (DoctorsResponse doctors) {
        emit(GetAllDoctorsSuccess(doctors.data ?? []));
      },
      onError: (ApiErrorModel error) {
        emit(GetAllDoctorsError(error));
      },
    );
  }

  void getDoctorById(int id) async {
    emit(GetDoctorByIdLoading());
    final response = await _homeRepoImpl.getDoctorById(id);

    response.when(
      onSuccess: (DoctorsResponse doctor) {
        emit(GetDoctorByIdSuccess(doctor.data!.first));
      },
      onError: (ApiErrorModel error) {
        emit(GetDoctorByIdError(error));
      },
    );
  }

  void getDoctorsByCategory(int categoryId) async {
    emit(GetDoctorsByCategoryLoading());
    final response = await _homeRepoImpl.getDoctorsByCategory(categoryId);

    response.when(
      onSuccess: (DoctorsResponse doctors) {
        emit(GetDoctorsByCategorySuccess(doctors.data ?? []));
      },
      onError: (ApiErrorModel error) {
        emit(GetDoctorsByCategoryError(error));
      },
    );
  }
}
