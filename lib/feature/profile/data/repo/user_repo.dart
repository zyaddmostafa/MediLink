import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/user_api_service.dart';
import '../model/get_user_response.dart';
import '../model/update_user_request.dart';

class UserRepo {
  final UserApiService apiService;

  UserRepo(this.apiService);

  Future<ApiResult<UserResponse>> getUserProfile() async {
    try {
      final response = await apiService.getUserProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserResponse>> updateUserProfile(
    UpdateUserRequest request,
  ) async {
    try {
      final response = await apiService.updateUserProfile(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
