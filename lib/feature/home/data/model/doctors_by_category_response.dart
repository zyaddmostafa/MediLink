import 'package:json_annotation/json_annotation.dart';
import 'doctor_model.dart';
part 'doctors_by_category_response.g.dart';

@JsonSerializable()
class DoctorsByCategoryResponse {
  final String? message;
  final CategoryData? data;
  final bool? status;
  final int? code;

  DoctorsByCategoryResponse({this.message, this.data, this.status, this.code});

  factory DoctorsByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorsByCategoryResponseFromJson(json);
}

@JsonSerializable()
class CategoryData {
  final int? id;
  final String? name;
  final List<DoctorModel>? doctors;

  CategoryData({this.id, this.name, this.doctors});

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
}
