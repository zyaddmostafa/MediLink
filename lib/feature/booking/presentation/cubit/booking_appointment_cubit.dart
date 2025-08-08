import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../../home/data/model/doctor_model.dart';
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

  void cancelAppointment(DoctorModel doctor) async {
    log('Cancel appointment called for doctor: ${doctor.name}');
    emit(CancelAppointmentLoading());
    final result = await _storeAppointmentRepo.cancelAppointment(doctor);

    result.when(
      onSuccess: (_) {
        log('Cancel appointment successful');
        emit(CancelAppointmentSuccess());
      },
      onError: (ApiErrorModel error) {
        log('Cancel appointment failed: ${error.message}');
        emit(CancelAppointmentFailure(error.message ?? 'An error occurred'));
      },
    );
  }
}
