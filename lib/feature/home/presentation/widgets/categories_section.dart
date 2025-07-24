import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import 'categories_grid_view.dart';
import 'home_body_header.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: HomeBodyHeader(
            title: 'Categories',
            onSeeAllTap: () => context.pushNamed(Routes.seeAllCategory),
          ),
        ),
        verticalSpacing(24),
        const CategoriesGridView(),
      ],
    );
  }
}
