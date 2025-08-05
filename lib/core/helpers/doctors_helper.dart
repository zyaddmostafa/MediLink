import '../../feature/home/data/model/category_model.dart';
import 'app_assets.dart';

class DoctorsHelpers {
  static const List<CategoryModel> all = [
    CategoryModel(
      id: 1,
      name: 'Cardiology',
      icon: Assets.imagesDoctorsCategorysCardiology,
    ),
    CategoryModel(
      id: 2,
      name: 'Dermatology',
      icon: Assets.imagesDoctorsCategorysDermatology,
    ),
    CategoryModel(
      id: 3,
      name: 'Neurology',
      icon: Assets.imagesDoctorsCategorysNeurology,
    ),
    CategoryModel(
      id: 4,
      name: 'Orthopedics',
      icon: Assets.imagesDoctorsCategorysOrthopedics,
    ),
    CategoryModel(
      id: 5,
      name: 'Pediatrics',
      icon: Assets.imagesDoctorsCategorysPediatrics,
    ),
    CategoryModel(
      id: 6,
      name: 'Gynecology',
      icon: Assets.imagesDoctorsCategorysGynecology,
    ),
    CategoryModel(
      id: 7,
      name: 'Ophthalmology',
      icon: Assets.imagesDoctorsCategorysOphthalmology,
    ),
    CategoryModel(
      id: 8,
      name: 'Urology',
      icon: Assets.imagesDoctorsCategorysUrology,
    ),
    CategoryModel(
      id: 9,
      name: 'Gastroenterology',
      icon: Assets.imagesDoctorsCategorysGastroenterology,
    ),
    CategoryModel(
      id: 10,
      name: 'Psychiatry',
      icon: Assets.imagesDoctorsCategorysPsychiatry,
    ),
  ];

  /// Get popular categories (first 8 for home screen grid)
  static List<CategoryModel> getPopularCategories() {
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
          suffix = '${parts[1]}';
        }
      }

      final List<String> timeParts = timeOnly.split(':');
      if (timeParts.length >= 2) {
        return '${timeParts[0]}:${timeParts[1]}$suffix';
      }
    }
    return time.toLowerCase();
  }

  /// Format time range from start and end time
  static String formatTimeRange(String startTime, String endTime) {
    return '${formatTime(startTime)} - ${formatTime(endTime)}';
  }

  /// Format date from "day/month" to "day Month dayName" format
  /// Example: "4/8" -> "4 August Sunday"
  static String formatDayMonth(String dayMonth, {int? year}) {
    try {
      final parts = dayMonth.split('/');
      if (parts.length != 2) return dayMonth;

      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final currentYear = year ?? DateTime.now().year;

      // Create DateTime object
      final date = DateTime(currentYear, month, day);

      // Month names
      const monthNames = [
        '',
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];

      // Day names
      const dayNames = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ];

      final monthName = monthNames[month];
      final dayName = dayNames[date.weekday - 1];

      return '$day $monthName $dayName';
    } catch (e) {
      return dayMonth; // Return original if parsing fails
    }
  }

  /// Format DateTime to "day Month dayName" format
  /// Example: DateTime(2025, 8, 4) -> "4 August Sunday"
  static String formatDateToDayMonth(DateTime date) {
    // Month names
    const monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    // Day names
    const dayNames = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];

    final monthName = monthNames[date.month];
    final dayName = dayNames[date.weekday - 1];

    return '${date.day} $monthName $dayName';
  }

  static List<String> generateTimeSlots({
    required String startTime,
    required String endTime,
  }) {
    final List<String> timeSlots = [];

    // Parse start time (handle AM/PM format)
    final startTime24 = _parseTimeWithAmPm(startTime);
    final endTime24 = _parseTimeWithAmPm(endTime);

    // Convert to total minutes for easier calculation
    int currentMinutes = startTime24['hour']! * 60 + startTime24['minute']!;
    int endMinutes = endTime24['hour']! * 60 + endTime24['minute']!;

    while (currentMinutes + 30 <= endMinutes) {
      // Calculate current time
      int currentHour = currentMinutes ~/ 60;
      int currentMin = currentMinutes % 60;

      // Calculate end time (30 minutes later)
      int nextMinutes = currentMinutes + 30;
      int nextHour = nextMinutes ~/ 60;
      int nextMin = nextMinutes % 60;

      // Format times in 12-hour format with AM/PM
      String startTimeStr = _formatTo12Hour(currentHour, currentMin);
      String endTimeStr = _formatTo12Hour(nextHour, nextMin);

      timeSlots.add('$startTimeStr - $endTimeStr');

      // Move to next 30-minute slot
      currentMinutes += 30;
    }

    return timeSlots;
  }

  // Parse time with AM/PM format (e.g., "14:00 am", "2:30 pm", "14:00")
  static Map<String, int> _parseTimeWithAmPm(String timeStr) {
    String cleanTime = timeStr.trim().toLowerCase();
    bool isAm = cleanTime.contains('am');
    bool isPm = cleanTime.contains('pm');

    // Remove AM/PM from string
    cleanTime = cleanTime.replaceAll(RegExp(r'\s*(am|pm)\s*'), '');

    final parts = cleanTime.split(':');
    int hour = int.parse(parts[0]);
    int minute = parts.length > 1 ? int.parse(parts[1]) : 0;

    // Convert to 24-hour format
    if (isPm && hour != 12) {
      hour += 12;
    } else if (isAm && hour == 12) {
      hour = 0;
    }
    // If no AM/PM specified, assume it's already in 24-hour format

    return {'hour': hour, 'minute': minute};
  }

  // Format time to 12-hour format with AM/PM
  static String _formatTo12Hour(int hour, int minute) {
    String period = hour >= 12 ? 'PM' : 'AM';
    int displayHour = hour;

    if (hour == 0) {
      displayHour = 12;
    } else if (hour > 12) {
      displayHour = hour - 12;
    }

    return '${displayHour.toString()}:${minute.toString().padLeft(2, '0')} $period';
  }
}
