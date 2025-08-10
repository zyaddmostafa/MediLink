import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/doctor_by_id_response.dart';
import '../../data/model/doctor_model.dart';
import '../../data/model/doctors_by_category_response.dart';
import '../../data/model/doctors_response.dart';
import '../../data/repo/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepoImpl _homeRepoImpl;
  HomeCubit(this._homeRepoImpl) : super(HomeCubitInitial());

  void getAllDoctors() async {
    emit(AllDoctorsLoading());
    final response = await _homeRepoImpl.getAllDoctors();

    response.when(
      onSuccess: (DoctorsResponse doctors) {
        emit(AllDoctorsSuccess(doctors.data ?? []));
      },
      onError: (ApiErrorModel error) {
        emit(AllDoctorsError(error));
      },
    );
  }

  void searchDoctors(String query) async {
    emit(SearchDoctorsLoading());
    final response = await _homeRepoImpl.searchDoctors(query);

    response.when(
      onSuccess: (DoctorsResponse doctor) {
        emit(SearchDoctorsSuccess(doctor.data ?? []));
      },
      onError: (ApiErrorModel error) {
        emit(SearchDoctorsError(error));
      },
    );
  }

  void getDoctorsByCategory(int categoryId) async {
    emit(DoctorsByCategoryLoading());
    final response = await _homeRepoImpl.getDoctorsByCategory(categoryId);

    response.when(
      onSuccess: (DoctorsByCategoryResponse doctors) {
        emit(DoctorsByCategorySuccess(doctors.data?.doctors ?? []));
      },
      onError: (ApiErrorModel error) {
        emit(DoctorsByCategoryError(error));
      },
    );
  }

  void getDoctorById(int id) async {
    emit(DoctorByIdLoading());
    final response = await _homeRepoImpl.getDoctorById(id);

    response.when(
      onSuccess: (DoctorByIdResponse doctor) {
        emit(DoctorByIdSuccess(doctor.data));
      },

      onError: (ApiErrorModel error) {
        emit(DoctorByIdError(error));
      },
    );
  }
}
