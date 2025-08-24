import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class AccountInfoItem extends StatelessWidget {
  final String title;
  final String? value;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final VoidCallback? onTap;
  const AccountInfoItem({
    super.key,
    required this.title,
    this.value,
    required this.icon,
    this.iconColor = AppColor.black,
    this.textColor = AppColor.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            horizontalSpacing(8),
            Text(
              title,
              style: AppTextStyles.font18Medium.copyWith(color: textColor),
            ),
            const Spacer(),
            value != null
                ? Text(value!, style: AppTextStyles.font16Bold)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
