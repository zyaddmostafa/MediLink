import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../model/get_user_response.dart';
import '../model/update_user_request.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @GET(ApiConstants.getUserProfile)
  Future<UserResponse> getUserProfile();

  @PUT(ApiConstants.updateUserProfile)
  Future<UserResponse> updateUserProfile(@Body() UpdateUserRequest request);
}
