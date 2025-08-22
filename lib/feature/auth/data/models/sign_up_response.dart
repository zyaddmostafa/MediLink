import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? message;
  @JsonKey(name: 'data')
  UserModel? userData;
  bool? status;
  int? code;

  SignupResponse({this.message, this.userData, this.status, this.code});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
