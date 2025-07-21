import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import 'doctor_rate.dart';

class DoctorsCard extends StatelessWidget {
  final bool isFavorite;
  const DoctorsCard({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFF4F4F6)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.assetsImagesDoctorFemale1,
                height: 32.r,
                width: 32.r,
              ),
              horizontalSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. Jane Smith', style: AppTextStyles.font14SemiBold),
                  verticalSpacing(4),
                  Text(
                    'Cardiologist',
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColor.doctorCardSubtitle,
                    ),
                  ),
                  verticalSpacing(8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      const DoctorRate(textColor: AppColor.black),
                      horizontalSpacing(24),
                      SvgPicture.asset(
                        Assets.assetsSvgsTime,
                        colorFilter: const ColorFilter.mode(
                          AppColor.grey,
                          BlendMode.srcIn,
                        ),
                        width: 18.r,
                        height: 18.r,
                      ),
                      Text(
                        '10:30 pm - 11:30 pm',
                        style: AppTextStyles.font14Medium,
                      ),
                    ],
                  ),
                ],
              ),

              Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 28,
                color: AppColor.red,
              ),
            ],
          ),
          verticalSpacing(16),
          CustomElevatedButton(
            textColor: AppColor.primary,
            backgroundColor: AppColor.doctorCardButton,
            text: 'Book Appointment',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
