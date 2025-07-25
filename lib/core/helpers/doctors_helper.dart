import '../../feature/home/data/model/category_model.dart';
import 'app_assets.dart';

class DoctorsHelpers {
  static const List<CategoryModel> all = [
    CategoryModel(
      id: 1,
      name: 'Cardiology',
      icon: Assets.assetsImagesDoctorsCategorysCardiology,
    ),
    CategoryModel(
      id: 2,
      name: 'Dermatology',
      icon: Assets.assetsImagesDoctorsCategorysDermatology,
    ),
    CategoryModel(
      id: 3,
      name: 'Neurology',
      icon: Assets.assetsImagesDoctorsCategorysNeurology,
    ),
    CategoryModel(
      id: 4,
      name: 'Orthopedics',
      icon: Assets.assetsImagesDoctorsCategorysOrthopedics,
    ),
    CategoryModel(
      id: 5,
      name: 'Pediatrics',
      icon: Assets.assetsImagesDoctorsCategorysPediatrics,
    ),
    CategoryModel(
      id: 6,
      name: 'Gynecology',
      icon: Assets.assetsImagesDoctorsCategorysGynecology,
    ),
    CategoryModel(
      id: 7,
      name: 'Ophthalmology',
      icon: Assets.assetsImagesDoctorsCategorysOphthalmology,
    ),
    CategoryModel(
      id: 8,
      name: 'Urology',
      icon: Assets.assetsImagesDoctorsCategorysUrology,
    ),
    CategoryModel(
      id: 9,
      name: 'Gastroenterology',
      icon: Assets.assetsImagesDoctorsCategorysGastroenterology,
    ),
    CategoryModel(
      id: 10,
      name: 'Psychiatry',
      icon: Assets.assetsImagesDoctorsCategorysPsychiatry,
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

  /// Format time from "HH:MM:SS" to "HH:MM"
  static String formatTime(String time) {
    if (time.contains(':')) {
      // Handle AM/PM suffix
      String suffix = '';
      String timeOnly = time;

      if (time.toUpperCase().contains('AM') ||
          time.toUpperCase().contains('PM')) {
        final parts = time.split(' ');
        if (parts.length >= 2) {
          timeOnly = parts[0];
          suffix = ' ${parts[1]}';
        }
      }

      final List<String> timeParts = timeOnly.split(':');
      if (timeParts.length >= 2) {
        return '${timeParts[0]}:${timeParts[1]}$suffix';
      }
    }
    return time;
  }

  /// Format time range from start and end time
  static String formatTimeRange(String startTime, String endTime) {
    return '${formatTime(startTime)} - ${formatTime(endTime)}';
  }
}
