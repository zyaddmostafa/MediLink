import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/favorites/favorite_doctor_service.dart';
import '../../../../../core/favorites/favorite_toogle_method.dart';
import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/doctors_images.dart';
import '../../../../../core/helpers/doctors_helper.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/model/button_properties_model.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../data/model/doctor_model.dart';
import 'doctor_rate.dart';

class DoctorsCard extends StatefulWidget {
  final DoctorModel? doctor;
  final ButtonPropertiesModel buttonProperties;

  const DoctorsCard({super.key, this.doctor, required this.buttonProperties});

  @override
  State<DoctorsCard> createState() => _DoctorsCardState();
}

class _DoctorsCardState extends State<DoctorsCard> {
  late final FavoriteDoctorService _favoriteService;

  @override
  void initState() {
    super.initState();
    _favoriteService = getIt<FavoriteDoctorService>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.lightGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.blueGrey),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorsImages.doctorCardImage(widget.doctor!),
              horizontalSpacing(8),
              _doctorCardBody(),
              horizontalSpacing(8),
              buildFavoriteIcon(_favoriteService, widget.doctor!),
            ],
          ),
          verticalSpacing(16),
          CustomElevatedButton(
            properties: ButtonPropertiesModel(
              textColor: widget.buttonProperties.textColor,
              backgroundColor: widget.buttonProperties.backgroundColor,
              text: widget.buttonProperties.text,
              onPressed: widget.buttonProperties.onPressed,
              isLoading: widget.buttonProperties.isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _doctorCardBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.doctor?.name ?? 'Default Doctor Name',
            style: AppTextStyles.font14SemiBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpacing(4),
          Text(
            widget.doctor?.specialization?.name ?? 'Default Specialization',
            style: AppTextStyles.font14Regular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpacing(8),
          Row(
            children: [
              const DoctorRate(textColor: AppColor.black),
              horizontalSpacing(24),
              SvgPicture.asset(
                Assets.svgsTime,
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
                  DoctorsHelpers.convertStartAndEndTimeTo12HourFormat(
                    widget.doctor?.startTime ?? '',
                    widget.doctor?.endTime ?? '',
                  ),
                  style: AppTextStyles.font14Medium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
