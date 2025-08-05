import 'package:json_annotation/json_annotation.dart';

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
  final DoctorResponse doctor;
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
class DoctorResponse {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  final String degree;
  final SpecializationResponse specialization;
  final CityResponse city;
  @JsonKey(name: 'appoint_price')
  final int appointPrice;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;

  DoctorResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.degree,
    required this.specialization,
    required this.city,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);
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

@JsonSerializable()
class SpecializationResponse {
  final int id;
  final String name;

  SpecializationResponse({required this.id, required this.name});

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) =>
      _$SpecializationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationResponseToJson(this);
}

@JsonSerializable()
class CityResponse {
  final int id;
  final String name;
  final GovernrateResponse governrate;

  CityResponse({
    required this.id,
    required this.name,
    required this.governrate,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}

@JsonSerializable()
class GovernrateResponse {
  final int id;
  final String name;

  GovernrateResponse({required this.id, required this.name});

  factory GovernrateResponse.fromJson(Map<String, dynamic> json) =>
      _$GovernrateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GovernrateResponseToJson(this);
}
