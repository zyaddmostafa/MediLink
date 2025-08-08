import 'dart:developer';

import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../../../home/data/model/doctor_model.dart';
import '../apis/booking_appointment_api_service.dart';
import '../local/cancle_appoinmets_local_service.dart';
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

  Future<ApiResult<GetStoredAppointmentResponse>>
  getStoredAppointments() async {
    try {
      final response = await apiService.getStoredAppointments();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> cancelAppointment(DoctorModel doctor) async {
    try {
      log('Repo: Attempting to cancel appointment for doctor: ${doctor.name}');
      await cancelledAppointmentsLocalService.addCancelledAppointment(doctor);
      log('Repo: Successfully added doctor to cancelled appointments');
      return ApiResult.success(null);
    } catch (error) {
      log('Repo: Error cancelling appointment: $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
