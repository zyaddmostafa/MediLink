import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppointmentSchedule extends StatelessWidget {
  final String date, time;
  const AppointmentSchedule({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
          ),
          child: Column(
            children: [
              Text(date, style: AppTextStyles.font16Bold),
              verticalSpacing(8),
              Text('Date ', style: AppTextStyles.font16Regular),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
          ),
          child: Column(
            children: [
              Text(time, style: AppTextStyles.font16Bold),
              verticalSpacing(8),
              Text('Time', style: AppTextStyles.font16Regular),
            ],
          ),
        ),
      ],
    );
  }
}
