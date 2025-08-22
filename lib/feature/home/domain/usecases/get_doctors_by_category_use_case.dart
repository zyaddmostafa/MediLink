import '../../../../core/api_helpers/api_result.dart';
import '../../../../core/favorites/favorite_doctor_service.dart';
import '../../../../core/model/api_response_model.dart';
import '../../data/model/doctor_model.dart';
import '../../data/repo/home_repo_impl.dart';
import 'base_use_case.dart';

class GetDoctorsByCategoryUseCase
    extends UseCase<ApiResult<List<DoctorModel>>, int> {
  final HomeRepoImpl _homeRepo;
  final FavoriteDoctorService _favoriteService;

  GetDoctorsByCategoryUseCase(this._homeRepo, this._favoriteService);

  @override
  Future<ApiResult<List<DoctorModel>>> call(int categoryId) async {
    final result = await _homeRepo.getDoctorsByCategory(categoryId);

    return result.when(
      onSuccess: (ApiResponseModel<List<DoctorModel>> response) {
        final doctors = response.responseData ?? <DoctorModel>[];
        final doctorsWithFavorites = _addFavoriteStatusToList(doctors);
        return ApiResult.success(doctorsWithFavorites);
      },
      onError: (error) {
        return ApiResult.failure(error);
      },
    );
  }

  List<DoctorModel> _addFavoriteStatusToList(List<DoctorModel> doctors) {
    return doctors.map((doctor) {
      final isFav = _favoriteService.isFavorite(doctor.id ?? 0);
      return doctor.copyWith(isFavorite: isFav);
    }).toList();
  }
}
