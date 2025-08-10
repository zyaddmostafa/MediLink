// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_by_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsByCategoryResponse _$DoctorsByCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    DoctorsByCategoryResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CategoryData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DoctorsByCategoryResponseToJson(
        DoctorsByCategoryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      doctors: (json['doctors'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'doctors': instance.doctors,
    };
