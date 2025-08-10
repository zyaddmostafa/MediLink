import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../helpers/app_assets.dart';
import '../helpers/spacing.dart';
import '../theme/app_text_styles.dart';

class NoResultWidget extends StatelessWidget {
  final String message;
  const NoResultWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LottieBuilder.asset(Assets.lottieNoSearchResult),
        verticalSpacing(24),

        Text(message, style: AppTextStyles.font16Medium),
      ],
    );
  }
}
