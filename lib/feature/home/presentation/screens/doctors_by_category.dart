import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/doctors_list_view.dart';

class DoctorsByCategories extends StatelessWidget {
  final String categoryName;
  const DoctorsByCategories({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomAppBar(
                appBarwidget: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    '$categoryName Doctors',
                    style: AppTextStyles.font18Bold,
                  ),
                ),
              ),
            ),
            verticalSpacing(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Results', style: AppTextStyles.font18Bold),
            ),
            verticalSpacing(24),
            // Here you would typically include a widget that lists all doctors
            const Expanded(
              child: DoctorListView(isFavorite: false, doctors: []),
            ),
          ],
        ),
      ),
    );
  }
}
