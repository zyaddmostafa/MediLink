import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/spacing.dart';
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
        const Column(
          spacing: 16,
          children: [
            AccountInfoItem(
              title: 'Name',
              value: 'Zyad Mostafa',
              icon: Icons.person,
            ),

            AccountInfoItem(
              title: 'Email',
              value: 'zyadmostafa@gmail.com',
              icon: Icons.email,
            ),

            AccountInfoItem(
              title: 'Phone',
              value: '+1234567890',
              icon: Icons.phone,
            ),

            AccountInfoItem(
              title: 'Gender',
              value: 'Male',
              icon: FontAwesomeIcons.marsAndVenus,
            ),
          ],
        ),
        verticalSpacing(42),
      ],
    );
  }
}
