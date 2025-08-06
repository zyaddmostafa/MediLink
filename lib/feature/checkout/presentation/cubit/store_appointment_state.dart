part of 'store_appointment_cubit.dart';

@immutable
sealed class StoreAppointmentState {}

final class StoreAppointmentInitial extends StoreAppointmentState {}

final class StoreAppointmentLoading extends StoreAppointmentState {}

final class StoreAppointmentSuccess extends StoreAppointmentState {
  final StoreAppointmentResponse response;
  StoreAppointmentSuccess(this.response);
}

final class StoreAppointmentFailure extends StoreAppointmentState {
  final String errorMessage;
  StoreAppointmentFailure(this.errorMessage);
}
