import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/categories_grid_view.dart';
import '../widgets/doctors_list_view.dart';
import '../widgets/home_body_header.dart';
import '../widgets/home_header.dart';
import '../widgets/upcoming_appoinments_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HomeHeader(
                onSearchTap: () => context.pushNamed(Routes.searchScreen),
                onFavoriteTap: () => context.pushNamed(Routes.favoriteScreen),
              ),
            ),
            verticalSpacing(40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Upcoming Appointments',
                style: AppTextStyles.font18Bold,
              ),
            ),
            verticalSpacing(24),
            const UpcomingAppoinmentsListView(),

            verticalSpacing(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HomeBodyHeader(
                title: 'Categories',
                onSeeAllTap: () => context.pushNamed(Routes.seeAllCategory),
              ),
            ),
            verticalSpacing(24),
            const CategoriesGridView(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HomeBodyHeader(
                title: 'Find Doctors',
                onSeeAllTap: () => context.pushNamed(Routes.seeAllDoctors),
              ),
            ),
            verticalSpacing(24),
            const DoctorListView(isFavorite: false),
          ],
        ),
      ),
    );
  }
}
