import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/doctors_images.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/doctors_helper.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../data/model/doctor_model.dart';
import 'doctor_rate.dart';

class DoctorsCard extends StatelessWidget {
  final bool isFavorite;
  final DoctorModel? doctor;
  const DoctorsCard({super.key, this.isFavorite = false, this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  DoctorsImages.getRandomDoctorImage(doctor?.gender ?? 'male'),
                  height: 32.r,
                  width: 32.r,
                  cacheWidth: 64, // Performance optimization
                  cacheHeight: 64,
                  fit: BoxFit.cover,
                ),
              ),
              horizontalSpacing(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor?.name ?? 'Default Doctor Name',
                      style: AppTextStyles.font14SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpacing(4),
                    Text(
                      doctor?.specialization?.name ?? 'Default Specialization',
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColor.doctorCardSubtitle,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpacing(8),
                    Row(
                      children: [
                        const DoctorRate(textColor: AppColor.black),
                        horizontalSpacing(24),
                        SvgPicture.asset(
                          Assets.assetsSvgsTime,
                          width: 18.r,
                          height: 18.r,
                          colorFilter: const ColorFilter.mode(
                            AppColor.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                        horizontalSpacing(4),
                        Flexible(
                          child: Text(
                            DoctorsHelpers.formatTimeRange(
                              doctor?.startTime ?? '',
                              doctor?.endTime ?? '',
                            ),
                            style: AppTextStyles.font14Medium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
            onPressed: () {
              context.pushNamed(Routes.doctorInfo, arguments: doctor?.id ?? 0);
            },
          ),
        ],
      ),
    );
  }
}
