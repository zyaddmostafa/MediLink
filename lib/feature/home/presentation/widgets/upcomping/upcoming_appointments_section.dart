import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../booking/data/model/appointment_data.dart';
import 'upcoming_appointments_list_view.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  final List<AppointmentData> appointments;
  const UpcomingAppointmentsSection({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return appointments.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Upcoming Appointments',
                  style: AppTextStyles.font18Bold,
                ),
              ),
              verticalSpacing(24),
              UpcomingAppoinmentsListView(appointments: appointments),
              verticalSpacing(24),
            ],
          )
        : const SizedBox.shrink();
  }
}
