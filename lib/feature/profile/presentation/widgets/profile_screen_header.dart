import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_dioalog.dart';

class ProfileSreenHeader extends StatelessWidget {
  const ProfileSreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text('Profile', style: AppTextStyles.font16Bold),
          ),
        ),
        InkWell(
          onTap: () {
            CustomDialog.showConfirmationDialog(
              context: context,
              title: 'Edit Profile',
              confirmText: 'Got it',
              message:
                  'You Dont Have to Update The Password To Update the Account Information Just Update The Rest',
              onConfirm: () {
                context.pushNamed(Routes.editProfileScreen);
              },
            );
          },
          child: const Icon(
            FontAwesomeIcons.penToSquare,
            color: AppColor.primary,
          ),
        ),
      ],
    );
  }
}
