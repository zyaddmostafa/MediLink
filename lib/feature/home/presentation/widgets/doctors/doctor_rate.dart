import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/theme/app_text_styles.dart';

class DoctorRate extends StatelessWidget {
  final Color textColor;
  const DoctorRate({super.key, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '4.8',
          style: AppTextStyles.font14Medium.copyWith(color: textColor),
        ),
        SvgPicture.asset(Assets.assetsSvgsStar),
      ],
    );
  }
}
