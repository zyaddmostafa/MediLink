import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class HomeBodyHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  const HomeBodyHeader({super.key, required this.title, this.onSeeAllTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.font18Bold),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text('See All', style: AppTextStyles.font18Medium),
        ),
      ],
    );
  }
}
