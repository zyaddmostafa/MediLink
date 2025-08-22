import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../profile/data/local/user_local_service.dart';
import '../../data/local/notification_local_service.dart';

class HomeHeader extends StatelessWidget {
  final void Function()? onNotificationTap;
  final void Function()? onFavoriteTap;
  const HomeHeader({super.key, this.onNotificationTap, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    final userInfo = getIt<UserLocalService>().getUser();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyles.font14Medium.copyWith(color: AppColor.grey),
            ),
            Text(userInfo?.name ?? '', style: AppTextStyles.font18Bold),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onNotificationTap,
          child: const NotificationIcon(),
        ),
        horizontalSpacing(16),
        GestureDetector(
          onTap: onFavoriteTap,
          child: SvgPicture.asset(Assets.svgsFavinactive),
        ),
      ],
    );
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allows overflow
        children: [
          const Icon(FontAwesomeIcons.bell, color: AppColor.black, size: 24),
          Positioned(
            right: -0,
            top: -10,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  getIt<NotificationLocalService>().getListCount().toString(),
                  style: AppTextStyles.font12SemiBold.copyWith(
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
