import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import 'categories_grid_item.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: 8, // 4 horizontal × 2 vertical = 8 items
          itemBuilder: (context, index) {
            final categories = [
              {
                'title': 'Cardiology',
                'image': Assets.assetsImagesDoctorsCategorysCardiology,
              },
              {
                'title': 'Dermatology',
                'image': Assets.assetsImagesDoctorsCategorysDermatology,
              },
              {
                'title': 'Gastroenterology',
                'image': Assets.assetsImagesDoctorsCategorysGastroenterology,
              },
              {
                'title': 'Gynecology',
                'image': Assets.assetsImagesDoctorsCategorysGynecology,
              },
              {
                'title': 'Neurology',
                'image': Assets.assetsImagesDoctorsCategorysNeurology,
              },
              {
                'title': 'Ophthalmology',
                'image': Assets.assetsImagesDoctorsCategorysOphthalmology,
              },
              {
                'title': 'Orthopedics',
                'image': Assets.assetsImagesDoctorsCategorysOrthopedics,
              },
              {
                'title': 'Pediatrics',
                'image': Assets.assetsImagesDoctorsCategorysPediatrics,
              },
              {
                'title': 'Psychiatry',
                'image': Assets.assetsImagesDoctorsCategorysPsychiatry,
              },
              {
                'title': 'Urology',
                'image': Assets.assetsImagesDoctorsCategorysUrology,
              },
            ];
            return CategoriesGridItem(
              categoryName: categories[index % categories.length]['title']!,
              imagePath: categories[index % categories.length]['image']!,
            );
          },
        ),
      ),
    );
  }
}
