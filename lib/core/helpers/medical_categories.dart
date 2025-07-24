import 'app_assets.dart';

class MedicalCategories {
  static const List<CategoryModel> all = [
    CategoryModel(
      id: '1',
      name: 'Cardiology',
      icon: Assets.assetsImagesDoctorsCategorysCardiology,
    ),
    CategoryModel(
      id: '2',
      name: 'Dermatology',
      icon: Assets.assetsImagesDoctorsCategorysDermatology,
    ),
    CategoryModel(
      id: '3',
      name: 'Gastroenterology',
      icon: Assets.assetsImagesDoctorsCategorysGastroenterology,
    ),
    CategoryModel(
      id: '4',
      name: 'Gynecology',
      icon: Assets.assetsImagesDoctorsCategorysGynecology,
    ),
    CategoryModel(
      id: '5',
      name: 'Neurology',
      icon: Assets.assetsImagesDoctorsCategorysNeurology,
    ),
    CategoryModel(
      id: '6',
      name: 'Ophthalmology',
      icon: Assets.assetsImagesDoctorsCategorysOphthalmology,
    ),
    CategoryModel(
      id: '7',
      name: 'Orthopedics',
      icon: Assets.assetsImagesDoctorsCategorysOrthopedics,
    ),
    CategoryModel(
      id: '8',
      name: 'Pediatrics',
      icon: Assets.assetsImagesDoctorsCategorysPediatrics,
    ),
    CategoryModel(
      id: '9',
      name: 'Psychiatry',
      icon: Assets.assetsImagesDoctorsCategorysPsychiatry,
    ),
    CategoryModel(
      id: '10',
      name: 'Urology',
      icon: Assets.assetsImagesDoctorsCategorysUrology,
    ),
  ];

  /// Get popular categories (first 8 for home screen grid)
  static List<CategoryModel> getPopular() {
    return all.take(8).toList();
  }

  /// Get all category names
  static List<CategoryModel> getAllCategories() {
    return all;
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'CategoryModel(id: $id, name: $name, icon: $icon)';
}
