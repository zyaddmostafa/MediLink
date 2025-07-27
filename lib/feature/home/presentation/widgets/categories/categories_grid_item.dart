import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/model/category_model.dart';

class CategoriesGridItem extends StatelessWidget {
  final CategoryModel category;
  const CategoriesGridItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.doctorsByCategory, arguments: category);
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
                category.icon,
                width: 28.r,
                height: 28.r,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Assets.imagesDoctorsCategorysDermatology,
                    width: 28.r,
                    height: 28.r,
                    color: AppColor.black,
                  );
                },
              ),
              verticalSpacing(4),
              Flexible(
                child: Text(category.name, style: AppTextStyles.font12SemiBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
