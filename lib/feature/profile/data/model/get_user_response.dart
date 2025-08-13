import 'package:json_annotation/json_annotation.dart';

part 'get_user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int message;
  @JsonKey(name: 'data')
  final List<UserModel> userdata;
  final String status;
  final int code;

  UserResponse({
    required this.message,
    required this.userdata,
    required this.status,
    required this.code,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
