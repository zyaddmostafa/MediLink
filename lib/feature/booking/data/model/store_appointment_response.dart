import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/doctor_model.dart';

part 'store_appointment_response.g.dart';

@JsonSerializable()
class StoreAppointmentResponse {
  final String message;
  final AppointmentData data;
  final bool status;
  final int code;

  StoreAppointmentResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory StoreAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$StoreAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoreAppointmentResponseToJson(this);
}

@JsonSerializable()
class AppointmentData {
  final int id;
  final DoctorModel doctor;
  final PatientResponse patient;
  @JsonKey(name: 'appointment_time')
  final String appointmentTime;
  @JsonKey(name: 'appointment_end_time')
  final String appointmentEndTime;
  final String status;
  final String notes;
  @JsonKey(name: 'appointment_price')
  final int appointmentPrice;

  AppointmentData({
    required this.id,
    required this.doctor,
    required this.patient,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.notes,
    required this.appointmentPrice,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) =>
      _$AppointmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentDataToJson(this);
}

@JsonSerializable()
class PatientResponse {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String gender;

  PatientResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}
