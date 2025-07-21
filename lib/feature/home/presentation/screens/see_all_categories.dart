import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/see_all_categories_list_item.dart';

class SeeAllCategories extends StatelessWidget {
  const SeeAllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(16),
              CustomAppBar(
                appBarwidget: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'All Categories',
                    style: AppTextStyles.font18Bold,
                  ),
                ),
              ),
              verticalSpacing(24),
              Text('Results', style: AppTextStyles.font18Bold),
              verticalSpacing(24),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10, // Number of categories
                  itemBuilder: (context, index) {
                    // Sample category data - you can replace with real data
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
                        'image':
                            Assets.assetsImagesDoctorsCategorysGastroenterology,
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
                        'image':
                            Assets.assetsImagesDoctorsCategorysOphthalmology,
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

                    final category = categories[index % categories.length];

                    return Padding(
                      padding: EdgeInsets.only(bottom: index == 9 ? 0 : 16),
                      child: SeeAllCategoriesListItem(
                        categoryName: category['title']!,
                        imagePath: category['image']!,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
