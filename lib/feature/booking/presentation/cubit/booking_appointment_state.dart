part of 'booking_appointment_cubit.dart';

@immutable
sealed class BookingAppointmentState {}

final class BookingAppointmentInitial extends BookingAppointmentState {}

final class StoreAppointmentLoading extends BookingAppointmentState {}

final class StoreAppointmentSuccess extends BookingAppointmentState {
  final AppointmentData response;
  StoreAppointmentSuccess(this.response);
}

final class StoreAppointmentFailure extends BookingAppointmentState {
  final String errorMessage;
  StoreAppointmentFailure(this.errorMessage);
}

final class GetStoredAppointmentsLoading extends BookingAppointmentState {}

final class GetStoredAppointmentsSuccess extends BookingAppointmentState {
  final List<AppointmentData> response;
  GetStoredAppointmentsSuccess(this.response);
}

final class GetStoredAppointmentsFailure extends BookingAppointmentState {
  final String errorMessage;
  GetStoredAppointmentsFailure(this.errorMessage);
}
