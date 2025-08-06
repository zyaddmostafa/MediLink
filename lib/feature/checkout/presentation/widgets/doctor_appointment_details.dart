import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/doctors_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/model/appointment_details_model.dart';

class DoctorAppointmentDetails extends StatelessWidget {
  final AppointmentDetailsModel appointmentDetails;
  const DoctorAppointmentDetails({super.key, required this.appointmentDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _doctorCardImage(),
          horizontalSpacing(16),
          _appointmentDetails(
            doctorName: appointmentDetails.doctorName,
            doctorSpecialization: appointmentDetails.doctorSpecialization,
            appointmentRate: appointmentDetails.appointmentPrice.toString(),
          ),
          _doctorRate(),
        ],
      ),
    );
  }
}

ClipRRect _doctorCardImage() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
      DoctorsImages.getRandomDoctorImage('male'),
      height: 32.r,
      width: 32.r,
      cacheWidth: 64, // Performance optimization
      cacheHeight: 64,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.person, size: 32),
    ),
  );
}

Widget _appointmentDetails({
  required String doctorName,
  required String doctorSpecialization,
  required String appointmentRate,
}) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          doctorName,
          style: AppTextStyles.font14SemiBold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpacing(4),
        Text(doctorSpecialization, style: AppTextStyles.font14Regular),
        verticalSpacing(8),
        Text(
          'Appointment Rate: \$$appointmentRate',
          style: AppTextStyles.font14SemiBold,
        ),
      ],
    ),
  );
}

Row _doctorRate() {
  return Row(
    children: [
      Text(
        '4.5',
        style: AppTextStyles.font14Medium.copyWith(color: AppColor.black),
      ),
      horizontalSpacing(8),
      SvgPicture.asset(Assets.svgsStar),
    ],
  );
}
