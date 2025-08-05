import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../data/model/doctor_model.dart';
import 'appointment_booking_actions.dart';
import 'appointment_date_selector.dart';
import 'appointment_schedule_selector.dart';
import 'doctor_basic_info_header.dart';
import 'doctor_professional_details.dart';

class DoctorInfoBottomSheet extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorInfoBottomSheet({super.key, required this.doctor});

  @override
  State<DoctorInfoBottomSheet> createState() => _DoctorInfoBottomSheetState();
}

class _DoctorInfoBottomSheetState extends State<DoctorInfoBottomSheet> {
  DateTime? selectedDate; // Make it nullable for validation
  String? selectedTimeSlot; // Add time slot selection

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.615,

      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F031530),
            blurRadius: 24,
            offset: Offset(0, -4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Fixed header section (not scrollable)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DoctorBasicInfoHeader(doctor: widget.doctor),
          ),
          // Scrollable content section
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacing(24),
                    // Doctor professional details section
                    DoctorProfessionalDetails(
                      degree: widget.doctor.degree,
                      appointPrice: widget.doctor.appointPrice,
                      phone: widget.doctor.phone,
                    ),
                    verticalSpacing(24),
                    // Appointment date selection section
                    AppointmentDateSelector(
                      selectedDate: selectedDate,
                      onDateSelected: (DateTime date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                    verticalSpacing(24),
                    // Appointment schedule selection section
                    AppointmentScheduleSelector(
                      selectedTimeSlot: selectedTimeSlot,
                      startTime: widget.doctor.startTime!,
                      endTime: widget.doctor.endTime!,
                      onTimeSelected: (String timeSlot) {
                        setState(() {
                          selectedTimeSlot = timeSlot;
                        });
                      },
                    ),
                    verticalSpacing(40),
                    // Booking actions section
                    AppointmentBookingActions(
                      selectedDate: selectedDate,
                      selectedTimeSlot: selectedTimeSlot,
                      doctorId: widget.doctor.id!,
                      doctorName: widget.doctor.name!,
                      doctorSpecialization: widget.doctor.specialization!.name!,
                      appointmentPrice: widget.doctor.appointPrice!,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
