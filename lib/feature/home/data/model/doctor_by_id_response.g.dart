// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_by_id_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorByIdResponse _$DoctorByIdResponseFromJson(Map<String, dynamic> json) =>
    DoctorByIdResponse(
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as bool,
      code: (json['code'] as num).toInt(),
    );

Map<String, dynamic> _$DoctorByIdResponseToJson(DoctorByIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
      'code': instance.code,
    };
