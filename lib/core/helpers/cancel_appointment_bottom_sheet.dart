import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/booking/data/model/appointment_data.dart';
import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_elevated_button.dart';
import '../model/button_properties_model.dart';
import '../../feature/home/presentation/widgets/date_and_time.dart';
import '../../feature/home/presentation/widgets/doctors/doctor_rate.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import 'spacing.dart';
import 'doctors_images.dart';

class BookingAppointmentBottomSheet {
  static Future<dynamic> show({
    required BuildContext context,
    required AppointmentData appointmentData,
    required VoidCallback onPressed,
    required String buttonText,
    required BookingAppointmentCubit bookingCubit,
  }) {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: false, // keep it within the same navigator scope
      builder: (context) => Container(
        height: MediaQuery.sizeOf(context).height * 0.4,
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
                _doctorCardImage(appointmentData.doctor.gender),
                horizontalSpacing(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointmentData.doctor.name!,
                      style: AppTextStyles.font18Bold,
                    ),
                    verticalSpacing(4),
                    Text(
                      'Specialization - ${appointmentData.doctor.specialization!.name}',
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
            Text(
              appointmentData.appointmentTime,
              style: AppTextStyles.font16Regular,
            ),
            verticalSpacing(24),
            CustomElevatedButton(
              properties: ButtonPropertiesModel(
                text: buttonText,
                textColor: AppColor.white,
                backgroundColor: AppColor.primary,
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static ClipRRect _doctorCardImage(String? gender) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        DoctorsImages.getRandomDoctorImage(gender ?? 'male'),
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
