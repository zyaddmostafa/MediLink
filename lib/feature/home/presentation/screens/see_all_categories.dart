import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/helpers/medical_categories.dart';
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
                  itemCount: MedicalCategories.getAllCategories().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: index == 9 ? 0 : 16),
                      child: SeeAllCategoriesListItem(
                        categoryName:
                            MedicalCategories.getAllCategories()[index].name,
                        imagePath:
                            MedicalCategories.getAllCategories()[index].icon,
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
