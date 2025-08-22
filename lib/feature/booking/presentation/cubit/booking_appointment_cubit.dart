import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/api_helpers/api_error_model.dart';
import '../../data/model/appointment_data.dart';
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
        emit(StoreAppointmentSuccess(response.responseData!));
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
        emit(GetStoredAppointmentsSuccess(response.responseData!));
      },
      onError: (ApiErrorModel error) {
        emit(GetStoredAppointmentsFailure(error));
      },
    );
  }

  void getFilteredAppointments() async {
    emit(GetStoredAppointmentsLoading());
    final result = await _filteredAppointmentUseCase
        .filteredAppointmentsFromTheCanceled();

    result.when(
      onSuccess: (filteredAppointments) {
        emit(GetStoredAppointmentsSuccess(filteredAppointments));
      },
      onError: (ApiErrorModel error) {
        emit(GetStoredAppointmentsFailure(error));
      },
    );
  }

  void getCancelledAppointments() {
    emit(GetCancelledAppointmentsLoading());

    try {
      final result = _storeAppointmentRepo.getCancelledAppointments();
      emit(GetCancelledAppointmentsSuccess(result));
    } catch (e) {
      emit(GetCancelledAppointmentsFailure(e.toString()));
    }
  }

  void cancelAppointment(AppointmentData appointment) async {
    emit(CancelAppointmentLoading());
    try {
      await _storeAppointmentRepo.addCanceledAppointment(appointment);
      // Refresh cancelled appointments
      emit(CancelAppointmentSuccess());
      getCancelledAppointments();
    } catch (e) {
      emit(CancelAppointmentFailure(e.toString()));
    }
  }

  void rescheduleAppointment(int id) async {
    emit(RescheduleAppointmentLoading());
    try {
      await _storeAppointmentRepo.rescheduleAppointment(id);
      getCancelledAppointments(); // Refresh cancelled appointments
      emit(RescheduleAppointmentSuccess());
    } catch (e) {
      emit(RescheduleAppointmentFailure(e.toString()));
    }
  }
}
