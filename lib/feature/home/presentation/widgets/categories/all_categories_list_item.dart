import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/model/category_model.dart';

class AllCategoriesListItem extends StatelessWidget {
  final CategoryModel category;

  const AllCategoriesListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the category details page
        Navigator.pushNamed(
          context,
          Routes.doctorsByCategory,
          arguments: category,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.veryLightGrey,
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Row(
          children: [
            // Category Image
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                category.icon,
                width: 36.r,
                height: 36.r,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.medical_services,
                    size: 36.r,
                    color: AppColor.primary,
                  );
                },
              ),
            ),

            horizontalSpacing(16),

            // Category Title
            Expanded(
              child: Text(category.name, style: AppTextStyles.font16Medium),
            ),

            // Arrow Icon
            Icon(Icons.arrow_forward_ios, size: 16.r, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
