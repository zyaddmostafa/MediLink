import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class AccountInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AccountInfoItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.black, size: 24),
          horizontalSpacing(8),
          Text(
            title,
            style: AppTextStyles.font18Medium.copyWith(color: AppColor.black),
          ),
          const Spacer(),
          Text(value, style: AppTextStyles.font16Bold),
        ],
      ),
    );
  }
}
