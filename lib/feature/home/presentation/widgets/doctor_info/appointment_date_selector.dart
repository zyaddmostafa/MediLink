import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../core/helpers/doctors_helper.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../doctors/select_appointment_date.dart';

class AppointmentDateSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const AppointmentDateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Select Date', style: AppTextStyles.font18Bold),
            if (selectedDate == null)
              Text(
                ' *',
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.red),
              ),
          ],
        ),
        verticalSpacing(16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedDate == null
                  ? AppColor.red.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectAppointmentDate(
            onDateSelected: (DateTime selectedDate) {
              onDateSelected(selectedDate);
              log(
                'Selected date: ${DoctorsHelpers.formatDayMonth(selectedDate.toString())}',
              );
            },
          ),
        ),
      ],
    );
  }
}
