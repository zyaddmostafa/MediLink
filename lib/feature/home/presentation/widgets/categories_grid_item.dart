import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategoriesGridItem extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  const CategoriesGridItem({
    super.key,
    required this.categoryName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.doctorsByCategory, arguments: categoryName);
      },
      child: Container(
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
                imagePath,
                width: 28.r,
                height: 28.r,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.assetsImagesDoctorsCategorysDermatology,
                    width: 28.r,
                    height: 28.r,
                    color: AppColor.black,
                  );
                },
              ),
              verticalSpacing(4),
              Flexible(
                child: Text(categoryName, style: AppTextStyles.font12SemiBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
