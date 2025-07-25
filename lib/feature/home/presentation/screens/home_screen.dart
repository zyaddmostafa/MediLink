import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../cubit/home_cubit.dart';
import '../widgets/categories_section.dart';
import '../widgets/doctors_section.dart';
import '../widgets/home_header.dart';
import '../widgets/upcoming_appointments_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the API call when screen loads
    context.read<HomeCubit>().getAllDoctors();
  }

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
          current is AllDoctorsSuccess ||
          current is AllDoctorsLoading ||
          current is AllDoctorsError,
      builder: (context, state) {
        if (state is AllDoctorsLoading || state is AllDoctorsSuccess) {
          return Expanded(
            child: DoctorsSection(
              isLoading: state is AllDoctorsLoading,
              doctors: state is AllDoctorsSuccess
                  ? state.doctors
                  : generateSkeletonDoctors(),
            ),
          );
        } else {
          return const Center(child: Text('Error fetching doctors'));
        }
      },
    );
  }
}
