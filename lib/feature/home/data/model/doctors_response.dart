import 'package:json_annotation/json_annotation.dart';

part 'doctors_response.g.dart';

// Helper function to parse int from string or int
int? _parseIntFromString(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}

@JsonSerializable()
class DoctorsResponse {
  final String? message;
  final List<Doctor>? data;
  final bool? status;
  @JsonKey(fromJson: _parseIntFromString)
  final int? code;

  DoctorsResponse({this.message, this.data, this.status, this.code});

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorsResponseFromJson(json);
}

@JsonSerializable()
class Doctor {
  @JsonKey(fromJson: _parseIntFromString)
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  final String? address;
  final String? description;
  final String? degree;
  final Specialization? specialization;
  final City? city;
  @JsonKey(name: 'appoint_price', fromJson: _parseIntFromString)
  final int? appointPrice;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.address,
    this.description,
    this.degree,
    this.specialization,
    this.city,
    this.appointPrice,
    this.startTime,
    this.endTime,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}

@JsonSerializable()
class Specialization {
  @JsonKey(fromJson: _parseIntFromString)
  final int? id;
  final String? name;

  Specialization({this.id, this.name});

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      _$SpecializationFromJson(json);
}

@JsonSerializable()
class City {
  @JsonKey(fromJson: _parseIntFromString)
  final int? id;
  final String? name;
  final Governrate? governrate;

  City({this.id, this.name, this.governrate});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@JsonSerializable()
class Governrate {
  @JsonKey(fromJson: _parseIntFromString)
  final int? id;
  final String? name;

  Governrate({this.id, this.name});

  factory Governrate.fromJson(Map<String, dynamic> json) =>
      _$GovernrateFromJson(json);
}
