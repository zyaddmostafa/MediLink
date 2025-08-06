import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../model/store_appointment_request.dart';
import '../model/store_appointment_response.dart';
part 'store_appointment_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class StoreAppointmentApiService {
  factory StoreAppointmentApiService(Dio dio, {String baseUrl}) =
      _StoreAppointmentApiService;
  @POST(ApiConstants.bookAppointment)
  Future<StoreAppointmentResponse> storeAppointment(
    @Body() StoreAppointmentRequest appointmentData,
  );
}
