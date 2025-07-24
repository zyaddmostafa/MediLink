import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../widgets/doctor_info_details.dart';
import '../widgets/select_appointment_date.dart';

class DoctorInfo extends StatefulWidget {
  final String doctorId;
  const DoctorInfo({super.key, required this.doctorId});

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: MediaQuery.sizeOf(context).height * 0.615,
        width: double.infinity,

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
            // Fixed content (not scrollable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 140),
                    child: Divider(color: AppColor.divider, thickness: 2),
                  ),
                  verticalSpacing(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('David H. Brown0', style: AppTextStyles.font18Bold),
                      Row(
                        children: [
                          Text('4.5', style: AppTextStyles.font14Regular),
                          horizontalSpacing(4),
                          SvgPicture.asset(Assets.assetsSvgsStar),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(8),
                  Text(
                    'Psychologists | New York City',
                    style: AppTextStyles.font16Regular.copyWith(
                      color: AppColor.grey,
                    ),
                  ),
                  verticalSpacing(24),
                  const Divider(color: AppColor.divider, thickness: 2),
                ],
              ),
            ),
            // Scrollable content starting from doctor details
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const DoctorInfoDetails(
                              value: 'PhDs',
                              label: 'Degree',
                            ),
                            horizontalSpacing(24),
                            const DoctorInfoDetails(
                              value: '\$200',
                              label: 'Price',
                            ),
                            horizontalSpacing(24),
                            const DoctorInfoDetails(
                              value: '+1-801-346-6622',
                              label: 'Phone Number',
                            ),
                          ],
                        ),
                      ),
                      verticalSpacing(24),
                      Text('Select Date', style: AppTextStyles.font18Bold),
                      verticalSpacing(16),
                      SelectAppointmentDate(
                        onDateSelected: (DateTime selectedDate) {
                          this.selectedDate = selectedDate;
                          // Handle date selection
                          log('Selected date: $selectedDate');
                        },
                      ),
                      verticalSpacing(24),
                      Text('Note', style: AppTextStyles.font18Bold),
                      verticalSpacing(16),
                      // TextField for note input
                      CustomTextFromField(
                        hintText: 'Enter your note here',
                        controller: _noteController,
                        maxLines: 3,
                      ),
                      verticalSpacing(40),
                      CustomElevatedButton(
                        text: 'Book Appointment',
                        onPressed: () {},
                      ),
                      verticalSpacing(
                        24,
                      ), // Extra space at bottom for better scrolling
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: DoctorInfoScreenHeader(),
            ),
            Positioned(
              top: 114,
              left: 0,
              right: 0,
              child: Image.asset(Assets.assetsImagesHeartBackgroundShadow),
            ),
            Positioned(
              top: 58,
              left: 60,
              right: 60,

              child: Image.asset(Assets.assetsImagesDoctorImage, height: 280),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorInfoScreenHeader extends StatelessWidget {
  const DoctorInfoScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomAppBar(
        iconColor: AppColor.white,
        appBarwidget: Expanded(
          child: Row(
            children: [
              horizontalSpacing(16),
              Text(
                'Doctor Info',
                style: AppTextStyles.font16Bold.copyWith(color: AppColor.white),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Handle search tap
                },
                child: SvgPicture.asset(
                  Assets.assetsSvgsSearch,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              horizontalSpacing(24),
              GestureDetector(
                onTap: () {
                  // Handle favorite tap
                },
                child: SvgPicture.asset(
                  Assets.assetsSvgsFavinactive,
                  colorFilter: const ColorFilter.mode(
                    AppColor.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
