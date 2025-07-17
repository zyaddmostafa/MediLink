import 'package:doctor_appoinment/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppTextStyles.font24Bold));
  }
}
