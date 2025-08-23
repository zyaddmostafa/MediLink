import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../data/model/appointment_data.dart';
import 'upcoming_appointment_list_item.dart';

class UpcomingAppointmentListView extends StatelessWidget {
  final List<AppointmentData> appointments;
  const UpcomingAppointmentListView({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    log(appointments.length.toString());
    return ListView.separated(
      itemCount: appointments.length,
      separatorBuilder: (context, index) => verticalSpacing(12),
      itemBuilder: (context, index) {
        return UpcomingAppointmentListItem(
          appointmentsDate: appointments[index],
        );
      },
    );
  }
}
