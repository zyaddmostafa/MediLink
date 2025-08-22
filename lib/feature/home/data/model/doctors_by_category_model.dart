import 'package:json_annotation/json_annotation.dart';

import 'doctor_model.dart';
part 'doctors_by_category_model.g.dart';

@JsonSerializable()
class DoctorsByCategoryModel {
  @JsonKey(name: 'id')
  final int categoryId;

  @JsonKey(name: 'name')
  final String categoryName;
  final List<DoctorModel> doctors;

  DoctorsByCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.doctors,
  });

  factory DoctorsByCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorsByCategoryModelFromJson(json);
}
