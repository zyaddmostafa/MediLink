import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer';

import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/appoitmnet_data.dart';
import '../../data/model/store_appointment_request.dart';
import '../../data/repo/booking_appointment_repo.dart';
import '../../domain/use_case/filtered_appointment_use_case.dart';

part 'booking_appointment_state.dart';

class BookingAppointmentCubit extends Cubit<BookingAppointmentState> {
  final BookingAppointmentRepo _storeAppointmentRepo;
  final FilteredAppointmentUseCase _filteredAppointmentUseCase;

  BookingAppointmentCubit(
    this._storeAppointmentRepo,
    this._filteredAppointmentUseCase,
  ) : super(BookingAppointmentInitial());

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

  void getFilteredAppointments() async {
    emit(GetStoredAppointmentsLoading());
    final result = await _filteredAppointmentUseCase
        .filteredAppointmentsFromTheCanceled();

    result.when(
      onSuccess: (filteredAppointments) {
        log('Filtered appointments count: ${filteredAppointments.length}');
        emit(GetStoredAppointmentsSuccess(filteredAppointments));
      },
      onError: (ApiErrorModel error) {
        log('Error getting filtered appointments: ${error.message}');
        emit(
          GetStoredAppointmentsFailure(error.message ?? 'An error occurred'),
        );
      },
    );
  }

  void getCancelledAppointments() {
    log('getCancelledAppointments called');
    emit(GetCancelledAppointmentsLoading());

    final result = _storeAppointmentRepo.getCancelledAppointments();

    result.when(
      onSuccess: (cancelledAppointments) {
        log('Found ${cancelledAppointments.length} cancelled appointments');
        emit(GetCancelledAppointmentsSuccess(cancelledAppointments));
      },
      onError: (ApiErrorModel error) {
        log('Error getting cancelled appointments: ${error.message}');
        emit(
          GetCancelledAppointmentsFailure(error.message ?? 'An error occurred'),
        );
      },
    );
  }

  void cancelAppointment(AppointmentData appointment) async {
    log('Cancel appointment called for doctor: ${appointment.doctor.name}');
    emit(CancelAppointmentLoading());
    final result = await _storeAppointmentRepo.cancelAppointment(appointment);

    result.when(
      onSuccess: (cancelledAppointment) {
        log('Cancel appointment successful');
        emit(CancelAppointmentSuccess(cancelledAppointment));
        // Note: Don't refresh here - let the listener handle it
      },
      onError: (ApiErrorModel error) {
        log('Cancel appointment failed: ${error.message}');
        emit(CancelAppointmentFailure(error.message ?? 'An error occurred'));
      },
    );
  }

  void rescheduleAppointment(int id) async {
    log('Reschedule appointment called for ID: $id');
    emit(RescheduleAppointmentLoading());
    try {
      await _storeAppointmentRepo.rescheduleAppointment(id);
      getCancelledAppointments(); // Refresh cancelled appointments
      emit(RescheduleAppointmentSuccess());
    } catch (e) {
      log('Reschedule appointment failed: ${e.toString()}');
      emit(RescheduleAppointmentFailure(e.toString()));
    }
  }
}
