import 'package:flutter/material.dart';

import 'cancelled_appointment_list_view.dart';
import 'completed_appointment_list_view.dart';
import 'upcoming_appointment_list_view.dart';

class AppointmentTabBarBody extends StatelessWidget {
  final TabController tabController;
  const AppointmentTabBarBody({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        // Upcoming appointments
        UpcomingAppointmentListView(),
        // Completed appointments
        CompletedAppointmentListView(),
        // Cancelled appointments
        CancelledAppointmentListView(),
      ],
    );
  }
}
