import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/store_appointment_request.dart';
import '../../data/model/store_appointment_response.dart';
import '../../data/repo/booking_appointment_repo.dart';

part 'booking_appointment_state.dart';

class BookingAppointmentCubit extends Cubit<BookingAppointmentState> {
  final BookingAppointmentRepo _storeAppointmentRepo;
  BookingAppointmentCubit(this._storeAppointmentRepo)
    : super(BookingAppointmentInitial());

  void storeAppointment(StoreAppointmentRequest request) async {
    emit(StoreAppointmentLoading());
    final result = await _storeAppointmentRepo.storeAppointment(request);

    result.when(
      onSuccess: (response) {
        emit(StoreAppointmentSuccess(response.data));
      },
      onError: (ApiErrorModel error) {
        emit(StoreAppointmentFailure(error.message ?? 'An error occurred'));
      },
    );
  }

  void getStoredAppointments() async {
    emit(GetStoredAppointmentsLoading());
    final result = await _storeAppointmentRepo.getStoredAppointments();

    result.when(
      onSuccess: (response) {
        emit(GetStoredAppointmentsSuccess(response.data));
      },
      onError: (ApiErrorModel error) {
        emit(
          GetStoredAppointmentsFailure(error.message ?? 'An error occurred'),
        );
      },
    );
  }
}
