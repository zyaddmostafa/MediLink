import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/store_appointment_api_service.dart';
import '../model/store_appointment_request.dart';
import '../model/store_appointment_response.dart';

class StoreAppointmentRepo {
  final StoreAppointmentApiService apiService;

  StoreAppointmentRepo(this.apiService);

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
}
