import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../model/get_stored_appoinnmnet_response.dart';
import '../model/store_appointment_request.dart';
import '../model/store_appointment_response.dart';
part 'booking_appointment_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class BookingAppointmentApiService {
  factory BookingAppointmentApiService(Dio dio, {String baseUrl}) =
      _BookingAppointmentApiService;
  @POST(ApiConstants.bookAppointment)
  Future<StoreAppointmentResponse> storeAppointment(
    @Body() StoreAppointmentRequest appointmentData,
  );

  @GET(ApiConstants.getStoredAppointments)
  Future<GetStoredAppointmentResponse> getStoredAppointments();
}
