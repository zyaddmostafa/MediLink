import 'package:flutter/material.dart';
import '../helpers/extentions.dart';
import '../helpers/spacing.dart';
import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';

class CustomDialog {
  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
              ),
              verticalSpacing(16),

              // Title
              Text(
                title,
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(8),

              // Message
              Text(
                message,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColor.grey,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(24),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed ?? () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText ?? 'OK',
                    style: AppTextStyles.font16Medium.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.error, color: AppColor.red, size: 40),
              ),
              verticalSpacing(16),

              // Title
              Text(
                title,
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(8),

              // Message
              Text(
                message,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColor.grey,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpacing(24),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed ?? () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText ?? 'Try Again',
                    style: AppTextStyles.font16Medium.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmColor,
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Message
              Text(
                message,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColor.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: AppColor.grey),
                      ),
                      child: Text(
                        cancelText ?? 'Cancel',
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColor.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: confirmColor ?? AppColor.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        confirmText ?? 'Confirm',
                        style: AppTextStyles.font16Medium.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showLoadingDialog({
    required BuildContext context,
    String? message,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: AppColor.primary),
              const SizedBox(height: 16),
              Text(
                message ?? 'Please wait...',
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColor.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
