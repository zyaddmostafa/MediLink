import 'package:doctor_appoinment/core/helpers/spacing.dart';
import 'package:doctor_appoinment/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LabelAndTextField extends StatelessWidget {
  final String label;

  final Widget textFormField;
  const LabelAndTextField({
    super.key,
    required this.label,
    required this.textFormField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font16Medium),
        verticalSpacing(12),
        textFormField,
      ],
    );
  }
}
