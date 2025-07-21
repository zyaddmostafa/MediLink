import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorRate extends StatelessWidget {
  const DoctorRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '4.8',
          style: AppTextStyles.font14Medium.copyWith(color: AppColor.white),
        ),
        SvgPicture.asset(Assets.assetsSvgsStar),
      ],
    );
  }
}
