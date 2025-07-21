import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeBodyHeader extends StatelessWidget {
  final String title;
  const HomeBodyHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.font18Bold),
        Text(
          'See All',
          style: AppTextStyles.font18Medium.copyWith(color: AppColor.primary),
        ),
      ],
    );
  }
}
