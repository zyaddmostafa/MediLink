import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../models/login_request_body.dart';
import '../models/logout_response.dart';
import '../models/sign_up_request_body.dart';
import '../models/sign_up_response.dart';
import '../models/user_model.dart';
part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(ApiConstants.login)
  Future<UserModel> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody);

  @POST(ApiConstants.logout)
  Future<LogoutResponse> logout();
}
