import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../../../../core/model/api_response_model.dart';
import '../model/doctor_model.dart';
import '../model/doctors_by_category_model.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET(ApiConstants.getAllDoctors)
  Future<ApiResponseModel<List<DoctorModel>>> getAllDoctors();

  @GET('${ApiConstants.getDoctorById}/{id}')
  Future<ApiResponseModel<DoctorModel>> getDoctorById(@Path("id") int id);

  @GET('${ApiConstants.getDoctorsByCategory}/{categoryId}')
  Future<ApiResponseModel<DoctorsByCategoryModel>> getDoctorsByCategory(
    @Path("categoryId") int categoryId,
  );

  @GET('${ApiConstants.searchDoctors}?name={name}')
  Future<ApiResponseModel<List<DoctorModel>>> searchDoctors(
    @Query("name") String name,
  );
}
