import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'appointment_schedile.dart';

class AppointmentScheduleSection extends StatelessWidget {
  final String appointmentDate;
  final String appointmentTime;

  const AppointmentScheduleSection({
    super.key,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Schedule', style: AppTextStyles.font18Bold),
        verticalSpacing(24),
        AppointmentSchedule(date: appointmentDate, time: appointmentTime),
      ],
    );
  }
}
