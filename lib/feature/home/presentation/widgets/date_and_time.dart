import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class DateAndTime extends StatelessWidget {
  const DateAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          Assets.svgsCalender,
          width: 18.r,
          height: 18.r,
          colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        ),
        horizontalSpacing(8),
        Text(
          '5 Oct',
          style: AppTextStyles.font14SemiBold.copyWith(color: AppColor.white),
        ),
        horizontalSpacing(24),
        SvgPicture.asset(
          Assets.svgsTime,
          width: 18.r,
          height: 18.r,
          colorFilter: const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        ),
        horizontalSpacing(8),
        Text(
          '10:30pm',
          style: AppTextStyles.font14SemiBold.copyWith(color: AppColor.white),
        ),
      ],
    );
  }
}
