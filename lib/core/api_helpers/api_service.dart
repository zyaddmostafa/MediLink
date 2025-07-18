// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/auth/data/models/login_request_body.dart';
import '../../feature/auth/data/models/login_response.dart';
import '../../feature/auth/data/models/sign_up_request_body.dart';
import '../../feature/auth/data/models/sign_up_response.dart';
import 'api_constants.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody);
}
