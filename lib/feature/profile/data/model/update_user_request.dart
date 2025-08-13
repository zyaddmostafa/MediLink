import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';

@JsonSerializable()
class UpdateUserRequest {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String? password;

  UpdateUserRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    this.password,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
