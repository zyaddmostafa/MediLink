import 'package:json_annotation/json_annotation.dart';
part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> {
  String? message;
  bool? status;
  int? code;
  @JsonKey(name: 'data')
  T? responseData;

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseModelFromJson(json, fromJsonT);

  ApiResponseModel({this.message, this.status, this.code, this.responseData});
}
