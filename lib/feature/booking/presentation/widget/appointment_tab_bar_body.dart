import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/booking_appointment_cubit.dart';
import 'cancelled_appointment_list_view.dart';
import 'upcoming_appointment_list_view.dart';

class AppointmentTabBarBody extends StatelessWidget {
  final TabController tabController;

  const AppointmentTabBarBody({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        // Upcoming appointments
        _upcomingAppointmentBlocBuilder(),

        // Cancelled appointments
        const CancelledAppointmentListView(),
      ],
    );
  }

  BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>
  _upcomingAppointmentBlocBuilder() {
    return BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>(
      builder: (context, state) {
        if (state is GetStoredAppointmentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetStoredAppointmentsFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetStoredAppointmentsSuccess) {
          // Use the appointments from the state
          return UpcomingAppointmentListView(appointments: state.response);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
