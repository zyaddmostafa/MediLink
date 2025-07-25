import 'package:json_annotation/json_annotation.dart';

import 'doctor_model.dart';

part 'doctors_response.g.dart';

@JsonSerializable()
class DoctorsResponse {
  final String? message;
  final List<DoctorModel>? data;
  final bool? status;

  final int? code;

  DoctorsResponse({this.message, this.data, this.status, this.code});

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorsResponseFromJson(json);
}
