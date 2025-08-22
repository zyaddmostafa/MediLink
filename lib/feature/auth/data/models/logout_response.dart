import 'package:json_annotation/json_annotation.dart';

part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  String? message;
  @JsonKey(name: 'data')
  List<dynamic>? userData;
  bool? status;
  int? code;

  LogoutResponse({this.message, this.userData, this.status});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
}
