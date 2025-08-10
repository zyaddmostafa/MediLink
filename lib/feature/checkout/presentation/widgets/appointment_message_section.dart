import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_from_field.dart';

class AppointmentMessageSection extends StatelessWidget {
  final TextEditingController? messageController;
  final String? hintText;

  const AppointmentMessageSection({
    super.key,
    this.messageController,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Message', style: AppTextStyles.font18Bold),
        verticalSpacing(24),
        CustomTextFormField(
          controller: messageController,
          hintText: hintText ?? 'Write a message to the doctor',
          maxLines: 6,
        ),
      ],
    );
  }
}
