class AppointmentDetailsModel {
  final int appointmentId;
  final String doctorName;
  final String doctorSpecialization;
  final String appointmentPrice;
  final String appointmentDate;
  final String appointmentTime;
  final String? message;

  AppointmentDetailsModel({
    required this.appointmentId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentPrice,
    required this.appointmentDate,
    required this.appointmentTime,
    this.message,
  });
}
