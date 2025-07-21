import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'date_and_time.dart';
import 'doctor_rate.dart';

class UpcomingAppoinmentListItem extends StatelessWidget {
  const UpcomingAppoinmentListItem({super.key});

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
              Image.asset(
                Assets.assetsImagesDoctorMale1,
                width: 32.r,
                height: 32.r,
              ),
              horizontalSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    'Cardiologist',
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
          const DateAndTime(),
        ],
      ),
    );
  }
}
