import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = AppColor.primary,
    this.textColor = AppColor.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: AppColor.white)
          : Text(
              text,
              style: AppTextStyles.font16Bold.copyWith(color: textColor),
            ),
    );
  }
}
