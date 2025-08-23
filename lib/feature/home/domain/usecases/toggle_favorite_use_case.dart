import '../../../../core/favorites/favorite_doctor_service.dart';
import '../../../../core/model/api_response_model.dart';
import '../../data/repo/home_repo_impl.dart';
import '../../data/model/doctor_model.dart';
import 'base_use_case.dart';

class ToggleFavoriteUseCase extends UseCase<void, int> {
  final FavoriteDoctorService _favoriteService;
  final HomeRepoImpl _homeRepo;

  ToggleFavoriteUseCase(this._favoriteService, this._homeRepo);

  @override
  Future<void> call(int doctorId) async {
    // First, try to get the doctor from favorites (if already cached)
    DoctorModel? doctor = _favoriteService.getFavoriteDoctor(doctorId);

    // If not in favorites, fetch from API
    if (doctor == null) {
      final result = await _homeRepo.getDoctorById(doctorId);
      result.when(
        onSuccess: (ApiResponseModel<DoctorModel> response) {
          doctor = response.responseData;
        },
        onError: (error) {
          // If we can't fetch the doctor, we can still toggle the ID-based favorite
          doctor = null;
        },
      );
    }

    if (doctor != null) {
      await _favoriteService.toggleFavorite(doctor!);
    } else {
      // Fallback: if we can't get the doctor model, at least toggle the ID
      if (_favoriteService.isFavorite(doctorId)) {
        await _favoriteService.removeFromFavorites(doctorId);
      }
      // We can't add without the doctor model, so skip adding
    }
  }
}
