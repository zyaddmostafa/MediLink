import 'package:flutter/material.dart';

import '../../../../../core/helpers/doctors_helper.dart';
import 'all_categories_list_item.dart';

class AllCategoriesListView extends StatelessWidget {
  const AllCategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: DoctorsHelpers.getAllCategories().length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AllCategoriesListItem(
              category: DoctorsHelpers.getAllCategories()[index],
            ),
          );
        },
      ),
    );
  }
}
