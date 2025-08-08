import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/doctors_images.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../home/data/model/doctor_model.dart';
import '../../../home/presentation/widgets/date_and_time.dart';
import '../../../home/presentation/widgets/doctors/doctor_rate.dart';
import '../../../home/presentation/widgets/doctors/doctors_card.dart';
import '../../data/model/store_appointment_response.dart';
import '../cubit/booking_appointment_cubit.dart';
import 'cancle_appointment_bloc_listener.dart';

class UpcomingAppointmentListItem extends StatelessWidget {
  final AppointmentData appointmentsDate;

  const UpcomingAppointmentListItem({
    super.key,
    required this.appointmentsDate,
  });

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(bottom: 24),
              child: DoctorsCard(
                doctor: appointmentsDate.doctor,
                buttonProperties: ButtonPropertiesModel(
                  text: 'Cancel Appointment',
                  textColor: AppColor.primary,
                  backgroundColor: AppColor.doctorCardButton,

                  onPressed: () async {
                    // Debug print

                    await _cancelAppointmnetBottomSheet(
                      context,
                      appointmentsDate.doctor,
                      appointmentsDate.appointmentTime,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const CancelAppointmentBlocListener(),
      ],
    );
  }

  Future<dynamic> _cancelAppointmnetBottomSheet(
    BuildContext context,
    DoctorModel doctor,
    String appointmentTime,
  ) {
    // Capture the existing cubit from the current context
    final bookingCubit = context.read<BookingAppointmentCubit>();

    return showModalBottomSheet(
      context: context,
      useRootNavigator: false, // keep it within the same navigator scope
      builder: (context) => BlocProvider.value(
        value: bookingCubit,
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.35,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 140),
                child: Divider(color: AppColor.divider, thickness: 3),
              ),
              verticalSpacing(8),
              Text('Cancel Appointment', style: AppTextStyles.font18Bold),
              verticalSpacing(24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _doctorCardImage(),
                  horizontalSpacing(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor.name!, style: AppTextStyles.font18Bold),
                      verticalSpacing(4),
                      Text(
                        'Specialization - ${doctor.specialization!.name}',
                        style: AppTextStyles.font16Regular.copyWith(
                          color: AppColor.grey,
                        ),
                      ),
                      verticalSpacing(4),
                      const DateAndTime(),
                    ],
                  ),

                  const DoctorRate(textColor: AppColor.black),
                ],
              ),
              Text('Selected Date & Time', style: AppTextStyles.font18Bold),
              verticalSpacing(4),
              Text(appointmentTime, style: AppTextStyles.font16Regular),

              verticalSpacing(24),
              CustomElevatedButton(
                properties: ButtonPropertiesModel(
                  text: 'Cancel',
                  textColor: AppColor.white,
                  backgroundColor: AppColor.primary,
                  onPressed: () async {
                    context.pop();
                    // Use the context cubit since it's now provided via BlocProvider.value
                    bookingCubit.cancelAppointment(doctor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _doctorCardImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        DoctorsImages.getRandomDoctorImage('male'),
        height: 32.r,
        width: 32.r,
        cacheWidth: 64,
        cacheHeight: 64,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.person, size: 32),
      ),
    );
  }
}
