import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../cubit/home_cubit.dart';
import '../widgets/categories_section.dart';
import '../widgets/doctors_section.dart';
import '../widgets/home_header.dart';
import '../widgets/upcoming_appointments_section.dart';

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
            const UpcomingAppointmentsSection(),
            verticalSpacing(24),
            const CategoriesSection(),
            verticalSpacing(24),
            doctorsSectionBlocBuilder(),
          ],
        ),
      ),
    );
  }

  Widget doctorsSectionBlocBuilder() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetAllDoctorsSuccess ||
          current is GetAllDoctorsLoading ||
          current is GetAllDoctorsError,
      builder: (context, state) {
        if (state is GetAllDoctorsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllDoctorsError) {
          return const Center(child: Text('Error fetching doctors'));
        } else if (state is GetAllDoctorsSuccess) {
          return Expanded(child: DoctorsSection(doctors: state.doctors));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
