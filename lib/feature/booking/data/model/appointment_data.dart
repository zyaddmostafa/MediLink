import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../home/data/model/doctor_model.dart';
part 'appointment_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class AppointmentData {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final DoctorModel doctor;
  @HiveField(2)
  final PatientResponse patient;

  @JsonKey(name: 'appointment_time')
  @HiveField(3)
  final String appointmentTime;
  @JsonKey(name: 'appointment_end_time')
  @HiveField(4)
  final String appointmentEndTime;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final String notes;
  @JsonKey(name: 'appointment_price')
  @HiveField(7)
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
@HiveType(typeId: 5)
class PatientResponse {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
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
