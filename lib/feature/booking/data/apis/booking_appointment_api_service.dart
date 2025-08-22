import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_helpers/api_constants.dart';
import '../../../../core/model/api_response_model.dart';
import '../model/appointment_data.dart';
import '../model/store_appointment_request.dart';
part 'booking_appointment_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class BookingAppointmentApiService {
  factory BookingAppointmentApiService(Dio dio, {String baseUrl}) =
      _BookingAppointmentApiService;
  @POST(ApiConstants.bookAppointment)
  Future<ApiResponseModel<AppointmentData>> storeAppointment(
    @Body() StoreAppointmentRequest appointmentData,
  );

  @GET(ApiConstants.getStoredAppointments)
  Future<ApiResponseModel<List<AppointmentData>>> getStoredAppointments();
}
