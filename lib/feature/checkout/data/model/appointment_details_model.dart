class AppointmentDetailsModel {
  final int doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final int appointmentPrice;
  final String appointmentDate;
  final String appointmentTime;
  final String? message;

  AppointmentDetailsModel({
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentPrice,
    required this.appointmentDate,
    required this.appointmentTime,
    this.message,
  });

  AppointmentDetailsModel copyWith({
    int? doctorId,
    String? doctorName,
    String? doctorSpecialization,
    int? appointmentPrice,
    String? appointmentDate,
    String? appointmentTime,
    String? message,
  }) {
    return AppointmentDetailsModel(
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialization: doctorSpecialization ?? this.doctorSpecialization,
      appointmentPrice: appointmentPrice ?? this.appointmentPrice,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      message: message ?? this.message,
    );
  }
}
