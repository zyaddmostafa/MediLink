import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import 'upcoming_appointment_list_item.dart';

class UpcomingAppointmentListView extends StatelessWidget {
  const UpcomingAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (context, index) => verticalSpacing(12),
      itemBuilder: (context, index) {
        // Example data for appointments
        final appointments = ['Today', 'Tomorrow', '18 October'];

        return UpcomingAppointmentListItem(
          appointmentsDate: appointments[index],
        );
      },
    );
  }
}
