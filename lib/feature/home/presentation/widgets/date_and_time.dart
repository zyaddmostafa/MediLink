import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class DateAndTime extends StatelessWidget {
  final String? appointmentTime;

  const DateAndTime({super.key, this.appointmentTime});

  /// Parses appointment time string like "Friday, October 10, 2025 2:00 PM"
  /// Returns a map with 'date' and 'time' keys
  /// Example: {'date': 'Oct 10', 'time': '2:00 PM'}
  static Map<String, String> parseAppointmentTime(String appointmentTime) {
    try {
      // Split by comma and space to get parts
      final parts = appointmentTime.split(', ');

      if (parts.length >= 3) {
        // Extract month and day from "October 10"
        final monthDay = parts[1].trim();
        final monthDayParts = monthDay.split(' ');

        if (monthDayParts.length >= 2) {
          final month = monthDayParts[0];
          final day = monthDayParts[1];

          // Convert full month name to abbreviated form
          final monthAbbr = _getMonthAbbreviation(month);
          final dateString = '$monthAbbr $day';

          // Extract time from the last part "2025 2:00 PM"
          final yearTimePart = parts[2].trim();
          final spaceIndex = yearTimePart.indexOf(' ');

          if (spaceIndex != -1 && spaceIndex < yearTimePart.length - 1) {
            final timeString = yearTimePart.substring(spaceIndex + 1).trim();

            return {'date': dateString, 'time': timeString};
          }
        }
      }
    } catch (e) {
      // Return default values if parsing fails
      return {'date': 'Oct 10', 'time': '2:00 PM'};
    }

    // Fallback if parsing fails
    return {'date': 'Oct 10', 'time': '2:00 PM'};
  }

  /// Helper method to convert full month names to abbreviations
  static String _getMonthAbbreviation(String fullMonth) {
    const monthMap = {
      'January': 'Jan',
      'February': 'Feb',
      'March': 'Mar',
      'April': 'Apr',
      'May': 'May',
      'June': 'Jun',
      'July': 'Jul',
      'August': 'Aug',
      'September': 'Sep',
      'October': 'Oct',
      'November': 'Nov',
      'December': 'Dec',
    };

    return monthMap[fullMonth] ?? fullMonth.substring(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    // Parse the appointment time or use defaults
    final parsedTime = appointmentTime != null
        ? parseAppointmentTime(appointmentTime!)
        : {'date': '5 Oct', 'time': '10:30 PM'};

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Assets.svgsCalender,
          width: 18.r,
          height: 18.r,
          colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        ),
        horizontalSpacing(8),
        Text(
          parsedTime['date']!,
          style: AppTextStyles.font14SemiBold.copyWith(color: AppColor.white),
        ),
        horizontalSpacing(24),
        SvgPicture.asset(
          Assets.svgsTime,
          width: 18.r,
          height: 18.r,
          colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        ),
        horizontalSpacing(8),
        Text(
          parsedTime['time']!,
          style: AppTextStyles.font14SemiBold.copyWith(color: AppColor.white),
        ),
      ],
    );
  }
}
