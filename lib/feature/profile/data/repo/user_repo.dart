import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../../../../core/model/api_response_model.dart';
import '../apis/user_api_service.dart';
import '../local/user_local_service.dart';
import '../model/user_response.dart';
import '../model/update_user_request.dart';

class UserRepo {
  final UserApiService apiService;
  final UserLocalService userLocalService;

  UserRepo(this.apiService, this.userLocalService);

  Future<ApiResult<UserModel>> getUserProfile() async {
    try {
      final response = await apiService.getUserProfile();

      await userLocalService.saveUser(response.responseData!.first);
      final user = userLocalService.getUser();
      if (user == null) {
        return ApiResult.success(response.responseData!.first);
      } else {
        return ApiResult.success(user);
      }
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<List<UserModel>>>> updateUserProfile(
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
