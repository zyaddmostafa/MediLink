import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRichText extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback? onTap;
  const AuthRichText({
    super.key,
    required this.text,
    required this.linkText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: AppTextStyles.font14Regular.copyWith(color: AppColor.grey),

        children: [
          TextSpan(
            text: linkText,
            style: AppTextStyles.font14SemiBold.copyWith(color: AppColor.black),
            recognizer: TapGestureRecognizer()..onTap = (onTap ?? () {}),
          ),
        ],
      ),
    );
  }
}
