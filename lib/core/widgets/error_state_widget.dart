import 'package:flutter/material.dart';

import '../api_helpers/api_error_handler.dart';
import '../helpers/spacing.dart';
import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class ErrorStateWidget extends StatelessWidget {
  final Map<String, dynamic> errorMessages;
  final String? errorMessage;
  final VoidCallback? onRetry;
  const ErrorStateWidget({
    super.key,
    required this.errorMessages,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              errorMessage ?? extractErrorMessages(errorMessages).toString(),
              style: AppTextStyles.font18Bold.copyWith(color: AppColor.red),
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpacing(16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blueGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: Text('Retry', style: AppTextStyles.font16Bold),
          ),
        ],
      ),
    );
  }
}
