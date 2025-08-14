import '../../../../core/api_helpers/api_result.dart';
import '../../../../core/api_helpers/api_error_model.dart';
import '../../../../core/favorites/favorite_doctor_service.dart';
import '../../data/model/doctor_by_id_response.dart';
import '../../data/model/doctor_model.dart';
import '../../data/repo/home_repo_impl.dart';
import 'base_use_case.dart';

class GetDoctorByIdUseCase extends UseCase<ApiResult<DoctorModel>, int> {
  final HomeRepoImpl _homeRepo;
  final FavoriteDoctorService _favoriteService;

  GetDoctorByIdUseCase(this._homeRepo, this._favoriteService);

  @override
  Future<ApiResult<DoctorModel>> call(int doctorId) async {
    final result = await _homeRepo.getDoctorById(doctorId);

    return result.when(
      onSuccess: (DoctorByIdResponse response) {
        final doctor = response.data;
        if (doctor == null) {
          return ApiResult.failure(
            ApiErrorModel(message: 'Doctor not found', code: 404),
          );
        }

        final isFav = _favoriteService.isFavorite(doctor.id ?? 0);
        final doctorWithFavorite = doctor.copyWith(isFavorite: isFav);
        return ApiResult.success(doctorWithFavorite);
      },
      onError: (error) {
        return ApiResult.failure(error);
      },
    );
  }
}
