import 'package:doctor_appoinment/core/theme/app_color.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: AppColor.primaryColor,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyles.font16Bold.copyWith(color: AppColor.white),
      ),
    );
  }
}
