import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/categories/all_categories_list_view.dart';

class SeeAllCategoriesScreen extends StatelessWidget {
  const SeeAllCategoriesScreen({super.key});

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
              const AllCategoriesListView(),
            ],
          ),
        ),
      ),
    );
  }
}
