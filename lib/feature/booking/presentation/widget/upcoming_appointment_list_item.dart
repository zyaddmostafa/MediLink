import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/doctors_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../home/presentation/widgets/date_and_time.dart';
import '../../../home/presentation/widgets/doctors/doctor_rate.dart';
import '../../../home/presentation/widgets/doctors/doctors_card.dart';

class UpcomingAppointmentListItem extends StatelessWidget {
  final String appointmentsDate;
  const UpcomingAppointmentListItem({
    super.key,
    required this.appointmentsDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appointmentsDate, style: AppTextStyles.font18Bold),
        verticalSpacing(12),
        // Add your appointment list here
        Column(
          children: List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: DoctorsCard(
                buttonProperties: ButtonPropertiesModel(
                  text: 'Cancel Appointment',
                  textColor: AppColor.primary,
                  backgroundColor: AppColor.doctorCardButton,
                  onPressed: () async {
                    // Debug print

                    await showModalBottomSheet(
                      context: context,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 140),
                              child: Divider(
                                color: AppColor.divider,
                                thickness: 2,
                              ),
                            ),
                            verticalSpacing(24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _doctorCardImage(),
                                horizontalSpacing(16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'name',
                                      style: AppTextStyles.font18Bold,
                                    ),
                                    verticalSpacing(4),
                                    Text(
                                      'Specialization - suez hospital ',
                                      style: AppTextStyles.font16Regular
                                          .copyWith(color: AppColor.grey),
                                    ),
                                    verticalSpacing(4),
                                    DateAndTime(),
                                  ],
                                ),

                                DoctorRate(textColor: AppColor.black),
                              ],
                            ),
                            Text(
                              'Selected Date',
                              style: AppTextStyles.font18Bold,
                            ),
                            verticalSpacing(4),
                            Text('10 oct', style: AppTextStyles.font16Regular),
                            verticalSpacing(16),
                            Text(
                              'Selected Time',
                              style: AppTextStyles.font18Bold,
                            ),
                            verticalSpacing(4),
                            Text(
                              '2:30 am - 3:00 pm',
                              style: AppTextStyles.font16Regular,
                            ),
                            verticalSpacing(24),
                            CustomElevatedButton(
                              properties: ButtonPropertiesModel(
                                text: 'Cancel',
                                textColor: AppColor.white,
                                backgroundColor: AppColor.primary,
                                onPressed: () async {
                                  await CustomDialog.showConfirmationDialog(
                                    context: context,
                                    title: 'Cancle Successfuly',
                                    message:
                                        'Your Appointment With Doctor Name is Cancelld ',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
