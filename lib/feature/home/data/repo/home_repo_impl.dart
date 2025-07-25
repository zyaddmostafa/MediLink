import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/home_api_service.dart';
import '../model/doctors_by_category_response.dart';
import '../model/doctors_response.dart';

class HomeRepoImpl {
  final HomeApiService _homeApiService;

  HomeRepoImpl(this._homeApiService);

  Future<ApiResult<DoctorsResponse>> getAllDoctors() async {
    try {
      final response = await _homeApiService.getAllDoctors();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorsResponse>> getDoctorById(int id) async {
    try {
      final response = await _homeApiService.getDoctorById(id);
      if (response.data != null && response.data!.isNotEmpty) {
        return ApiResult.success(response);
      } else {
        return ApiResult.failure(ApiErrorHandler.handle('Doctor not found'));
      }
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<DoctorsByCategoryResponse>> getDoctorsByCategory(
    int categoryId,
  ) async {
    try {
      final response = await _homeApiService.getDoctorsByCategory(categoryId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
