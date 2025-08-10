import 'package:json_annotation/json_annotation.dart';

import 'appoitmnet_data.dart';

part 'get_stored_appoinnmnet_response.g.dart';

@JsonSerializable()
class GetStoredAppointmentResponse {
  final String message;
  final List<AppointmentData> data;
  final bool status;
  final int code;

  GetStoredAppointmentResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory GetStoredAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetStoredAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetStoredAppointmentResponseToJson(this);
}
