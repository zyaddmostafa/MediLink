import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorInfoDetails extends StatelessWidget {
  final String value;
  final String label;

  const DoctorInfoDetails({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: AppTextStyles.font16Bold),
        verticalSpacing(4),
        Text(label, style: AppTextStyles.font16Regular),
      ],
    );
  }
}
