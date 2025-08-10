import 'package:json_annotation/json_annotation.dart';

import 'doctor_model.dart';
part 'doctor_by_id_response.g.dart';

@JsonSerializable()
class DoctorByIdResponse {
  final String message;
  final DoctorModel? data;
  final bool status;
  final int code;

  DoctorByIdResponse({
    required this.message,
    this.data,
    required this.status,
    required this.code,
  });

  factory DoctorByIdResponse.fromJson(json) =>
      _$DoctorByIdResponseFromJson(json);
}
