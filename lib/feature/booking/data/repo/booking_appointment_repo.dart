import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/booking_appointment_api_service.dart';
import '../local/cancle_appoinmets_local_service.dart';
import '../model/appoitmnet_data.dart';
import '../model/get_stored_appoinnmnet_response.dart';
import '../model/store_appointment_request.dart';
import '../model/store_appointment_response.dart';

class BookingAppointmentRepo {
  final BookingAppointmentApiService apiService;
  final CancelledAppointmentsLocalService cancelledAppointmentsLocalService;

  BookingAppointmentRepo(
    this.apiService,
    this.cancelledAppointmentsLocalService,
  );

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

  List<AppointmentData> getCancelledAppointments() {
    final response = cancelledAppointmentsLocalService
        .getCancelledAppointments();
    return response;
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

  Future<void> addCanceledAppointment(AppointmentData appointment) async {
    await cancelledAppointmentsLocalService.addCanceledAppointment(appointment);
  }

  Future<void> rescheduleAppointment(int id) async {
    await cancelledAppointmentsLocalService.deleteCancelledAppointmentById(id);
  }
}
