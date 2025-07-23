import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  final void Function()? onSearchTap;
  final void Function()? onFavoriteTap;
  const HomeHeader({super.key, this.onSearchTap, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyles.font14Medium.copyWith(color: AppColor.grey),
            ),
            Text('Zyad Mostafa', style: AppTextStyles.font18Bold),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSearchTap,
          child: SvgPicture.asset(Assets.assetsSvgsSearch),
        ),
        horizontalSpacing(24),
        GestureDetector(
          onTap: onFavoriteTap,
          child: const Icon(
            Icons.favorite_border,
            color: AppColor.black,
            size: 28,
          ),
        ),
      ],
    );
  }
}
