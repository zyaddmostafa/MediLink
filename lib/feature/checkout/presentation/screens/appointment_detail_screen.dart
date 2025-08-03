import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/doctors_images.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                appBarwidget: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Appointment Details',
                    style: AppTextStyles.font16Bold,
                  ),
                ),
              ),
              verticalSpacing(32),
              const DoctorAppointmentDetails(),
              verticalSpacing(24),
              Text('Schedule', style: AppTextStyles.font18Bold),
              verticalSpacing(24),

              const AppointmentSchedule(),
              verticalSpacing(24),
              Text('Message', style: AppTextStyles.font18Bold),
              verticalSpacing(24),
              CustomTextFormField(
                hintText: 'Enter your message here',
                controller: TextEditingController(),
                maxLines: 6,
              ),
              verticalSpacing(82),
              CustomElevatedButton(
                properties: ButtonPropertiesModel(
                  text: 'Next',
                  backgroundColor: AppColor.primary,
                  textColor: AppColor.white,
                  onPressed: () {
                    context.pushNamed(Routes.appointmentPaymentMethodsScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentSchedule extends StatelessWidget {
  const AppointmentSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
          ),
          child: Column(
            children: [
              Text('8 October, Sat', style: AppTextStyles.font16Bold),
              verticalSpacing(8),
              Text('Date ', style: AppTextStyles.font16Regular),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
          ),
          child: Column(
            children: [
              Text('10:00am-11:00am', style: AppTextStyles.font16Bold),
              verticalSpacing(8),
              Text('Time', style: AppTextStyles.font16Regular),
            ],
          ),
        ),
      ],
    );
  }
}

class DoctorAppointmentDetails extends StatelessWidget {
  const DoctorAppointmentDetails({super.key});

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
          _appointmentDetails(),
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

Widget _appointmentDetails() {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. John Doe',
          style: AppTextStyles.font14SemiBold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        verticalSpacing(4),
        Text(
          'Cardiologist | Heart Specialist',
          style: AppTextStyles.font14Regular,
        ),
        verticalSpacing(8),
        Text('Appointment Rate: \$150', style: AppTextStyles.font14SemiBold),
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
