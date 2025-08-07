import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../data/model/store_appointment_response.dart';
import 'upcoming_appointment_list_item.dart';

class UpcomingAppointmentListView extends StatelessWidget {
  final List<AppointmentData> appointments;
  const UpcomingAppointmentListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: appointments.length,
      separatorBuilder: (context, index) => verticalSpacing(12),
      itemBuilder: (context, index) {
        // Example data for appointments

        return UpcomingAppointmentListItem(
          appointmentsDate: appointments[index],
        );
      },
    );
  }
}
