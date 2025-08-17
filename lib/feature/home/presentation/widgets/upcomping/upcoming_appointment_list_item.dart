import 'package:flutter/material.dart';
import '../../../../../core/helpers/doctors_images.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../booking/data/model/appointment_data.dart';
import '../date_and_time.dart';
import '../doctors/doctor_rate.dart';

class UpcomingAppoinmentListItem extends StatelessWidget {
  final AppointmentData appointmentData;
  const UpcomingAppoinmentListItem({super.key, required this.appointmentData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColor.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorsImages.doctorCardImage(appointmentData.doctor),
              horizontalSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointmentData.doctor.name!,
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    appointmentData.doctor.specialization!.name!,
                    style: AppTextStyles.font14Medium.copyWith(
                      color: AppColor.babyBlue,
                    ),
                  ),
                  verticalSpacing(4),
                  const DoctorRate(textColor: AppColor.white),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10, left: 50),
                child: Icon(Icons.more_vert, color: AppColor.white, size: 24),
              ),
            ],
          ),
          verticalSpacing(16),
          DateAndTime(appointmentTime: appointmentData.appointmentTime),
        ],
      ),
    );
  }
}
