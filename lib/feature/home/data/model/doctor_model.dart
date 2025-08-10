import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'doctor_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class DoctorModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? photo;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final String? address;
  @HiveField(7)
  final String? description;
  @HiveField(8)
  final String? degree;
  @HiveField(9)
  final Specialization? specialization;
  @HiveField(10)
  final City? city;
  @JsonKey(name: 'appoint_price')
  @HiveField(11)
  final int? appointPrice;
  @JsonKey(name: 'start_time')
  @HiveField(12)
  final String? startTime;
  @JsonKey(name: 'end_time')
  @HiveField(13)
  final String? endTime;

  DoctorModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.address,
    this.description,
    this.degree,
    this.specialization,
    this.city,
    this.appointPrice,
    this.startTime,
    this.endTime,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 1)
class Specialization extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;

  Specialization({this.id, this.name});

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      _$SpecializationFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 2)
class City extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final Governrate? governrate;

  City({this.id, this.name, this.governrate});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}

@JsonSerializable()
@HiveType(typeId: 3)
class Governrate extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;

  Governrate({this.id, this.name});

  factory Governrate.fromJson(Map<String, dynamic> json) =>
      _$GovernrateFromJson(json);
}
