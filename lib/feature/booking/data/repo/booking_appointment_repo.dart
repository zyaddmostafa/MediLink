import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/booking_appointment_api_service.dart';
import '../model/get_stored_appoinnmnet_response.dart';
import '../model/store_appointment_request.dart';
import '../model/store_appointment_response.dart';

class BookingAppointmentRepo {
  final BookingAppointmentApiService apiService;

  BookingAppointmentRepo(this.apiService);

  Future<ApiResult<StoreAppointmentResponse>> storeAppointment(
    StoreAppointmentRequest request,
  ) async {
    try {
      final response = await apiService.storeAppointment(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetStoredAppointmentResponse>>
  getStoredAppointments() async {
    try {
      final response = await apiService.getStoredAppointments();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
