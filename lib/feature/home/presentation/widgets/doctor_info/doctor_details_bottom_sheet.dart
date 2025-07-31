import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/model/button_properties_model.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_from_field.dart';
import '../../../data/model/doctor_model.dart';
import '../doctors/select_appointment_date.dart';
import 'doctor_info_details.dart';

class DoctorDetailsBottomSheet extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorDetailsBottomSheet({super.key, required this.doctor});

  @override
  State<DoctorDetailsBottomSheet> createState() =>
      _DoctorDetailsBottomSheetState();
}

class _DoctorDetailsBottomSheetState extends State<DoctorDetailsBottomSheet> {
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      widget.doctor.name ?? 'Doctor Name',
                      style: AppTextStyles.font18Bold,
                    ),
                    Row(
                      children: [
                        Text('4.8', style: AppTextStyles.font14Regular),
                        horizontalSpacing(4),
                        SvgPicture.asset(Assets.svgsStar),
                      ],
                    ),
                  ],
                ),
                verticalSpacing(8),
                Text(
                  '${widget.doctor.specialization!.name} | ${widget.doctor.city!.name} City',
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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                            value: widget.doctor.degree ?? 'PhDs',
                            label: 'Degree',
                          ),
                          horizontalSpacing(24),
                          DoctorInfoDetails(
                            value: '\$${widget.doctor.appointPrice ?? '200'}',
                            label: 'Price',
                          ),
                          horizontalSpacing(24),
                          DoctorInfoDetails(
                            value: widget.doctor.phone ?? '+1-801-346-6622',
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
                        setState(() {});
                      },
                    ),
                    verticalSpacing(24),
                    Text('Note', style: AppTextStyles.font18Bold),
                    verticalSpacing(16),
                    // TextField for note input
                    CustomTextFormField(
                      hintText: 'Enter your note here',
                      controller: _noteController,
                      maxLines: 3,
                    ),
                    verticalSpacing(40),
                    CustomElevatedButton(
                      properties: ButtonPropertiesModel(
                        text: 'Book Appointment',
                        textColor: AppColor.white,
                        backgroundColor: AppColor.primary,
                        onPressed: () {},
                      ),
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
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}
