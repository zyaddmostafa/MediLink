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

final class CancelAppointmentLoading extends BookingAppointmentState {}

final class CancelAppointmentSuccess extends BookingAppointmentState {
  CancelAppointmentSuccess();
}

final class CancelAppointmentFailure extends BookingAppointmentState {
  final String errorMessage;
  CancelAppointmentFailure(this.errorMessage);
}

final class GetCancelledAppointmentsLoading extends BookingAppointmentState {}

final class GetCancelledAppointmentsSuccess extends BookingAppointmentState {
  final List<AppointmentData> response;
  GetCancelledAppointmentsSuccess(this.response);
}

final class GetCancelledAppointmentsFailure extends BookingAppointmentState {
  final String errorMessage;
  GetCancelledAppointmentsFailure(this.errorMessage);
}

final class RescheduleAppointmentLoading extends BookingAppointmentState {}

final class RescheduleAppointmentSuccess extends BookingAppointmentState {}

final class RescheduleAppointmentFailure extends BookingAppointmentState {
  final String errorMessage;
  RescheduleAppointmentFailure(this.errorMessage);
}
