import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../../../../core/model/api_response_model.dart';
import '../apis/auth_api_service.dart';
import '../models/login_request_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/user_model.dart';

class AuthRepo {
  final AuthApiService _apiService;
  AuthRepo(this._apiService);

  Future<ApiResult<ApiResponseModel<UserModel>>> login(
    LoginRequestBody loginRequestBody,
  ) async {
    try {
      final response = await _apiService.login(loginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<UserModel>>> signup(
    SignupRequestBody signupRequestBody,
  ) async {
    try {
      final response = await _apiService.signup(signupRequestBody);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ApiResponseModel<List<dynamic>>>> logout() async {
    try {
      final response = await _apiService.logout();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
