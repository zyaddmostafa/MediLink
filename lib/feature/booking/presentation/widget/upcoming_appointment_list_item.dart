import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/cancel_appointment_bottom_sheet.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/presentation/widgets/doctors/doctors_card.dart';
import '../../data/model/appointment_data.dart';
import '../cubit/booking_appointment_cubit.dart';

class UpcomingAppointmentListItem extends StatelessWidget {
  final AppointmentData appointmentsDate;

  const UpcomingAppointmentListItem({
    super.key,
    required this.appointmentsDate,
  });

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingAppointmentCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appointmentsDate.appointmentTime, style: AppTextStyles.font18Bold),
        verticalSpacing(12),
        // Add your appointment list here
        Column(
          children: List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DoctorsCard(
                doctor: appointmentsDate.doctor,
                buttonProperties: ButtonPropertiesModel(
                  text: 'Cancel Appointment',
                  textColor: AppColor.primary,
                  backgroundColor: AppColor.doctorCardButton,

                  onPressed: () async {
                    // Debug print
                    await BookingAppointmentBottomSheet.show(
                      context: context,
                      bookingCubit: bookingCubit,
                      appointmentData: appointmentsDate,
                      buttonText: 'Cancel Appointment',
                      onPressed: () {
                        context.pop();
                        bookingCubit.cancelAppointment(appointmentsDate);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
