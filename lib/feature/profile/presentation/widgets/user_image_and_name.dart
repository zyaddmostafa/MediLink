import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/local/user_local_service.dart';

class UserImageAndName extends StatelessWidget {
  const UserImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = getIt<UserLocalService>().getUser();
    return Column(
      children: [
        Image.asset(Assets.imagesUser, height: 110.h),
        verticalSpacing(8),
        Text(userInfo?.name ?? 'User', style: AppTextStyles.font18Bold),
      ],
    );
  }
}
