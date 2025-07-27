import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

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
