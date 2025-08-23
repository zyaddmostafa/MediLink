import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTextStyles.font14SemiBold.copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(milliseconds: 500),
    ),
  );
}
