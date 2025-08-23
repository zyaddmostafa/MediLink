import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../profile/presentation/cubit/user_cubit.dart';

class HomeHeader extends StatelessWidget {
  final void Function()? onNotificationTap;
  final void Function()? onFavoriteTap;
  const HomeHeader({super.key, this.onNotificationTap, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyles.font14Medium.copyWith(color: AppColor.grey),
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return Text(state.user.name, style: AppTextStyles.font18Bold);
                }
                return const SizedBox.shrink();
              },
            ),
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(FontAwesomeIcons.bell, color: AppColor.black, size: 24),
        Positioned(
          right: 4,
          top: -4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColor.red,
              borderRadius: BorderRadius.circular(12),
            ),
            constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
          ),
        ),
      ],
    );
  }
}
