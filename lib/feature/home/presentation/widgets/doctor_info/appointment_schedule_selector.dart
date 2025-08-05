import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../core/helpers/doctors_helper.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'schedule_time_grid.dart';

class AppointmentScheduleSelector extends StatelessWidget {
  final String? selectedTimeSlot;
  final String startTime;
  final String endTime;
  final Function(String) onTimeSelected;

  const AppointmentScheduleSelector({
    super.key,
    required this.selectedTimeSlot,
    required this.startTime,
    required this.endTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Schedule', style: AppTextStyles.font18Bold),
            if (selectedTimeSlot == null)
              Text(
                ' *',
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.red),
              ),
          ],
        ),
        verticalSpacing(16),
        ScheduleTimeGrid(
          startTime: DoctorsHelpers.formatTime(startTime),
          endTime: DoctorsHelpers.formatTime(endTime),
          selectedTime: selectedTimeSlot,
          onTimeSelected: (String timeSlot) {
            onTimeSelected(timeSlot);
            log('Selected time slot: $timeSlot');
          },
        ),
      ],
    );
  }
}
