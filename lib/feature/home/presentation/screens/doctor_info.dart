import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../data/model/doctor_model.dart';
import '../cubit/home_cubit.dart';
import '../widgets/doctors/doctor_info_details.dart';
import '../widgets/doctors/select_appointment_date.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({super.key});

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is DoctorByIdSuccess ||
          current is DoctorByIdLoading ||
          current is DoctorByIdError,
      builder: (context, state) {
        if (state is DoctorByIdLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is DoctorByIdError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.error.message ?? 'Unknown error'}'),
            ),
          );
        } else if (state is DoctorByIdSuccess) {
          final DoctorModel doctor = state.doctor!;
          return _buildDoctorInfoScreen(doctor);
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildDoctorInfoScreen(DoctorModel doctor) {
    // Example ID, replace with actual
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
                      Text(
                        doctor.name ?? 'Doctor Name',
                        style: AppTextStyles.font18Bold,
                      ),
                      Row(
                        children: [
                          Text('4.8', style: AppTextStyles.font14Regular),
                          horizontalSpacing(4),
                          SvgPicture.asset(Assets.assetsSvgsStar),
                        ],
                      ),
                    ],
                  ),
                  verticalSpacing(8),
                  Text(
                    '${doctor.specialization!.name} | ${doctor.city!.name} City',
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
                            DoctorInfoDetails(
                              value: doctor.degree ?? 'PhDs',
                              label: 'Degree',
                            ),
                            horizontalSpacing(24),
                            DoctorInfoDetails(
                              value: '\$${doctor.appointPrice ?? '200'}',
                              label: 'Price',
                            ),
                            horizontalSpacing(24),
                            DoctorInfoDetails(
                              value: doctor.phone ?? '+1-801-346-6622',
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
                  context.pushNamed(Routes.searchScreen);
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
