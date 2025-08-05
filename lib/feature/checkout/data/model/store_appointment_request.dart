import 'package:json_annotation/json_annotation.dart';
part 'store_appointment_request.g.dart';

@JsonSerializable()
class StoreAppointmentRequest {
  @JsonKey(name: 'doctor_id')
  final String doctorId;
  @JsonKey(name: 'start_time')
  final String appointmentDateAndTime;
  @JsonKey(name: 'notes')
  final String? message;

  StoreAppointmentRequest({
    required this.doctorId,
    required this.appointmentDateAndTime,

    this.message,
  });

  Map<String, dynamic> toJson() => _$StoreAppointmentRequestToJson(this);
}
