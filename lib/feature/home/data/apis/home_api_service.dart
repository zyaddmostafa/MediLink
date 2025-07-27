// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../model/doctor_by_id_response.dart';
import '../model/doctors_by_category_response.dart';
import '../model/doctors_response.dart';

part 'home_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  @GET(ApiConstants.getAllDoctors)
  Future<DoctorsResponse> getAllDoctors();

  @GET('${ApiConstants.getDoctorById}/{id}')
  Future<DoctorByIdResponse> getDoctorById(@Path("id") int id);

  @GET('${ApiConstants.getDoctorsByCategory}/{categoryId}')
  Future<DoctorsByCategoryResponse> getDoctorsByCategory(
    @Path("categoryId") int categoryId,
  );

  @GET('${ApiConstants.searchDoctors}?name={name}')
  Future<DoctorsResponse> searchDoctors(@Query("name") String name);
}
