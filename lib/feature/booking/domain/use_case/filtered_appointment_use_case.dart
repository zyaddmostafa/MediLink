import '../../../../core/api_helpers/api_result.dart';
import '../../data/local/cancle_appoinmets_local_service.dart';
import '../../data/model/appoitmnet_data.dart';
import '../../data/repo/booking_appointment_repo.dart';

class FilteredAppointmentUseCase {
  final BookingAppointmentRepo _repository;

  FilteredAppointmentUseCase(this._repository);

  Future<ApiResult<List<AppointmentData>>>
  filteredAppointmentsFromTheCanceled() async {
    final filteredList = <AppointmentData>[];
    final canceledAppointmentList =
        CancelledAppointmentsLocalService.getCancelledAppointments();

    final storedAppointments = await _repository.getStoredAppointments();

    return storedAppointments.when(
      onSuccess: (data) {
        for (var appointment in data.data) {
          if (!canceledAppointmentList.any(
            (canceled) => canceled.id == appointment.id,
          )) {
            filteredList.add(appointment);
          }
        }
        return ApiResult.success(filteredList);
      },
      onError: (error) {
        return ApiResult.failure(error);
      },
    );
  }
}
