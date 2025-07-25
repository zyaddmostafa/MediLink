// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorsResponse _$DoctorsResponseFromJson(Map<String, dynamic> json) =>
    DoctorsResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );
