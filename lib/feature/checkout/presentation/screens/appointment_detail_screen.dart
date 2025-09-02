import 'package:flutter/material.dart';

import '../../../../core/helpers/doctors_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/model/appointment_details_model.dart';
import '../widgets/appointment_details_actions.dart';
import '../widgets/appointment_details_header.dart';
import '../widgets/appointment_message_section.dart';
import '../widgets/appointment_schedule_section.dart';
import '../widgets/doctor_appointment_details.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final AppointmentDetailsModel appointmentDetails;
  const AppointmentDetailsScreen({super.key, required this.appointmentDetails});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppointmentDetailsHeader(),
                verticalSpacing(32),

                DoctorAppointmentDetails(
                  appointmentDetails: widget.appointmentDetails,
                ),
                verticalSpacing(24),

                AppointmentScheduleSection(
                  appointmentDate: DoctorsHelper.formatDateToDayMonth(
                    widget.appointmentDetails.appointmentDate,
                  ),
                  appointmentTime: widget.appointmentDetails.appointmentTime,
                ),
                verticalSpacing(24),

                AppointmentMessageSection(
                  messageController: _messageController,
                ),
                verticalSpacing(82),

                AppointmentDetailsActions(
                  appointmentDetails: widget.appointmentDetails,
                  message: _messageController.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
