import 'dart:developer';

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

  ApiResult<List<AppointmentData>> getCancelledAppointments() {
    try {
      final response = cancelledAppointmentsLocalService
          .getCancelledAppointments();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
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

  Future<ApiResult<List<AppointmentData>>> cancelAppointment(
    AppointmentData appointment,
  ) async {
    try {
      await cancelledAppointmentsLocalService.addCancelledAppointment(
        appointment,
      );
      final cancelledAppointment = cancelledAppointmentsLocalService
          .getCancelledAppointments();
      log('Repo: Successfully added appointment to cancelled appointments');
      return ApiResult.success(cancelledAppointment);
    } catch (error) {
      log('Repo: Error cancelling appointment: $error');
      log('Repo: Error type: ${error.runtimeType}');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<void> rescheduleAppointment(int id) async {
    await cancelledAppointmentsLocalService.deleteCancelledAppointmentById(id);
  }
}
