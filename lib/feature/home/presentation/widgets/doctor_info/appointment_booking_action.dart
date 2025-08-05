import 'package:flutter/material.dart';

import '../../../../../core/helpers/doctors_helper.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/model/button_properties_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../checkout/data/model/appointment_details_model.dart';

class AppointmentBookingActions extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTimeSlot;
  final int doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final int appointmentPrice;

  const AppointmentBookingActions({
    super.key,
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          properties: ButtonPropertiesModel(
            text: 'Book Appointment',
            textColor: AppColor.white,
            backgroundColor: AppColor.primary,
            onPressed: () {
              _validateAndBookAppointment(context);
            },
          ),
        ),
        verticalSpacing(24), // Extra space at bottom for better scrolling
      ],
    );
  }

  void _validateAndBookAppointment(BuildContext context) {
    // Validation for date selection
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select an appointment date'),
          backgroundColor: AppColor.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(milliseconds: 300),
        ),
      );
      return;
    }

    // Validation for time slot selection
    if (selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select an appointment time'),
          backgroundColor: AppColor.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(milliseconds: 300),
        ),
      );
      return;
    }

    // If validation passes, proceed to appointment details
    context.pushNamed(
      Routes.appointmentDetailsScreen,
      arguments: AppointmentDetailsModel(
        doctorId: doctorId,
        doctorName: doctorName,
        doctorSpecialization: doctorSpecialization,
        appointmentPrice: appointmentPrice,
        appointmentDate: DoctorsHelpers.formatDateToDayMonth(selectedDate!),
        appointmentTime: selectedTimeSlot!,
      ),
    );
  }
}
