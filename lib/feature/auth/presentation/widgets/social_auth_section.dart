import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'social_auth_item.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(child: Divider(thickness: 1, color: AppColor.grey)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('OR', style: AppTextStyles.font14Medium),
            ),
            const Expanded(child: Divider(thickness: 1, color: AppColor.grey)),
          ],
        ),
        verticalSpacing(32),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialAuthItem(
              svgImage: Assets.svgsGoogle,
              onTap: () => _showSnackBar(context, 'Google Auth Coming Soon'),
            ),
            horizontalSpacing(24),
            SocialAuthItem(
              svgImage: Assets.svgsFacebook,
              onTap: () => _showSnackBar(context, 'Facebook Auth Coming Soon'),
            ),
          ],
        ),
      ],
    );
  }
}

_showSnackBar(BuildContext context, String message) {
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
