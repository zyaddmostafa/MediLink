import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/categories/categories_section.dart';
import '../widgets/doctors/doctors_section.dart';
import '../widgets/home_header.dart';
import '../widgets/upcomping/upcoming_appointments_section.dart';

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
                onNotificationTap: () =>
                    context.pushNamed(Routes.notificationScreen),
                onFavoriteTap: () => context.pushNamed(Routes.favoriteScreen),
              ),
            ),

            verticalSpacing(24),

            const UpcomingAppointmentsSection(),

            verticalSpacing(24),

            const CategoriesSection(),

            verticalSpacing(24),

            const Expanded(child: DoctorsSection()),
          ],
        ),
      ),
    );
  }
}
