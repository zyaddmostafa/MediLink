import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 72.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.veryLightGrey,
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Image.asset(
              Assets.assetsImagesDoctorsCategorysCardiology,
              width: 28.r,
              height: 28.r,
              color: AppColor.black,
            ),
            verticalSpacing(4),
            Text(
              'Heart',
              style: AppTextStyles.font12SemiBold.copyWith(
                color: AppColor.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
