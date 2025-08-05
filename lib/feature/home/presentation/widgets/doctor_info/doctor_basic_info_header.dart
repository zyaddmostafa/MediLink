import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/model/doctor_model.dart';

class DoctorBasicInfoHeader extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorBasicInfoHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text(doctor.name ?? 'Doctor Name', style: AppTextStyles.font18Bold),
            Row(
              children: [
                Text(
                  '4.8',
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColor.black,
                  ),
                ),
                horizontalSpacing(4),
                SvgPicture.asset(Assets.svgsStar),
              ],
            ),
          ],
        ),
        verticalSpacing(8),
        Text(
          '${doctor.specialization!.name} | ${doctor.city!.name} City',
          style: AppTextStyles.font16Regular.copyWith(color: AppColor.grey),
        ),
        verticalSpacing(24),
        const Divider(color: AppColor.divider, thickness: 2),
      ],
    );
  }
}
