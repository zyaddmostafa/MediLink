import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'account_info_item.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account Information', style: AppTextStyles.font16Bold),
        verticalSpacing(16),
        Column(
          spacing: 16,
          children: [
            const AccountInfoItem(
              title: 'Name',
              value: 'Zyad Mostafa',
              icon: Icons.person,
            ),

            const AccountInfoItem(
              title: 'Email',
              value: 'zyadmostafa@gmail.com',
              icon: Icons.email,
            ),

            const AccountInfoItem(
              title: 'Phone',
              value: '+1234567890',
              icon: Icons.phone,
            ),

            const AccountInfoItem(
              title: 'Gender',
              value: 'Male',
              icon: FontAwesomeIcons.marsAndVenus,
            ),

            AccountInfoItem(
              title: 'My Favorite',
              icon: FontAwesomeIcons.heart,
              onTap: () => context.pushNamed(Routes.favoriteScreen),
            ),
            const AccountInfoItem(
              title: 'Sign Out',
              icon: FontAwesomeIcons.signOutAlt,
              iconColor: AppColor.red,
              textColor: AppColor.red,
            ),
          ],
        ),
      ],
    );
  }
}
