import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import 'categories_grid_item.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  static const _categories = [
    {
      'name': 'Cardiology',
      'image': Assets.assetsImagesDoctorsCategorysCardiology,
    },
    {
      'name': 'Dermatology',
      'image': Assets.assetsImagesDoctorsCategorysDermatology,
    },
    {
      'name': 'Neurology',
      'image': Assets.assetsImagesDoctorsCategorysNeurology,
    },
    {
      'name': 'Orthopedics',
      'image': Assets.assetsImagesDoctorsCategorysOrthopedics,
    },
    {
      'name': 'Pediatrics',
      'image': Assets.assetsImagesDoctorsCategorysPediatrics,
    },
    {
      'name': 'Psychiatry',
      'image': Assets.assetsImagesDoctorsCategorysPsychiatry,
    },
    {'name': 'Urology', 'image': Assets.assetsImagesDoctorsCategorysUrology},
    {
      'name': 'Gynecology',
      'image': Assets.assetsImagesDoctorsCategorysGynecology,
    },
  ];

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
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return RepaintBoundary(
            child: CategoriesGridItem(
              categoryName: category['name']!,
              imagePath: category['image']!,
            ),
          );
        },
      ),
    );
  }
}
