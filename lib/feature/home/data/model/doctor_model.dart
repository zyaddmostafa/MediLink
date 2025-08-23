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

  // Local field - not from API, used for UI state
  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(14, defaultValue: false)
  final bool? isFavorite;

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
    this.isFavorite = false,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  // Copy with method for updating favorite status
  DoctorModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? photo,
    String? gender,
    String? address,
    String? description,
    String? degree,
    Specialization? specialization,
    City? city,
    int? appointPrice,
    String? startTime,
    String? endTime,
    bool? isFavorite,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      description: description ?? this.description,
      degree: degree ?? this.degree,
      specialization: specialization ?? this.specialization,
      city: city ?? this.city,
      appointPrice: appointPrice ?? this.appointPrice,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
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
