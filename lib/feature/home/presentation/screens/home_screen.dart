import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/skeletonizer_dummy_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../booking/presentation/cubit/booking_appointment_cubit.dart';
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

            BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>(
              buildWhen: (previous, current) =>
                  current is GetStoredAppointmentsLoading ||
                  current is GetStoredAppointmentsSuccess ||
                  current is GetStoredAppointmentsFailure,
              builder: (context, state) {
                log('Current state: $state');
                if (state is GetStoredAppointmentsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: UpcomingAppointmentsSection(
                      appointments: SkeletonizerDummyData.dummyAppointmentsList,
                    ),
                  );
                } else if (state is GetStoredAppointmentsSuccess) {
                  return UpcomingAppointmentsSection(
                    appointments: state.response,
                  );
                } else if (state is GetStoredAppointmentsFailure) {
                  return const Center(
                    child: Text('Failed to load appointments'),
                  );
                }

                return const SizedBox.shrink();
              },
            ),

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
