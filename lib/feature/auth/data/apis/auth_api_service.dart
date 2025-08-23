import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../../../../core/model/api_response_model.dart';
import '../models/login_request_body.dart';
import '../models/sign_up_request_body.dart';
import '../models/user_model.dart';
part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<ApiResponseModel<UserModel>> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<ApiResponseModel<UserModel>> signup(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.logout)
  Future<ApiResponseModel<List<dynamic>>> logout();
}
