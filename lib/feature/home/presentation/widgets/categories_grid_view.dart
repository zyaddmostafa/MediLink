import 'package:flutter/material.dart';

import '../../../../core/helpers/medical_categories.dart';
import 'categories_grid_item.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: MedicalCategories.getPopular().length,
        itemBuilder: (context, index) {
          final category = MedicalCategories.getPopular()[index];
          return RepaintBoundary(
            child: CategoriesGridItem(
              categoryName: category.name,
              imagePath: category.icon,
            ),
          );
        },
      ),
    );
  }
}
