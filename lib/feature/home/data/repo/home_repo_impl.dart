import 'dart:developer';

import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../../../../core/model/api_response_model.dart';
import '../apis/home_api_service.dart';
import '../model/doctor_model.dart';
import '../model/doctors_by_category_model.dart';

class HomeRepoImpl {
  final HomeApiService _homeApiService;

  HomeRepoImpl(this._homeApiService);

  Future<ApiResult<ApiResponseModel<List<DoctorModel>>>> getAllDoctors() async {
    try {
      final response = await _homeApiService.getAllDoctors();
      log(
        'HomeRepoImpl: Fetched ${response.responseData?.length ?? 0} doctors',
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<DoctorModel>>> getDoctorById(int id) async {
    try {
      final response = await _homeApiService.getDoctorById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<DoctorsByCategoryModel>>>
  getDoctorsByCategory(int categoryId) async {
    try {
      final response = await _homeApiService.getDoctorsByCategory(categoryId);
      log(
        'HomeRepoImpl: Fetched ${response.responseData?.doctors.length ?? 0} doctors for category $categoryId',
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<List<DoctorModel>>>> searchDoctors(
    String query,
  ) async {
    try {
      final response = await _homeApiService.searchDoctors(query);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
