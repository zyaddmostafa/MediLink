import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const ProfileSreenHeader(),
              verticalSpacing(32),
              const UserImageAndName(),
              verticalSpacing(42),
              const AccountInfo(),
              CustomElevatedButton(
                properties: ButtonPropertiesModel(
                  text: 'Sign Out',
                  textColor: AppColor.white,
                  backgroundColor: AppColor.red,

                  onPressed: () {
                    // Handle sign out logic
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class UserImageAndName extends StatelessWidget {
  const UserImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesUser, height: 110.h),
        verticalSpacing(8),
        Text('Zyad Mostafa', style: AppTextStyles.font18Bold),
      ],
    );
  }
}

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
              message:
                  'You Dont Have to Update The Password To Update the Account Information Just Update The Rest',
              onConfirm: () {
                context.pop();
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

class AccountInfoItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const AccountInfoItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.black, size: 24),
          horizontalSpacing(8),
          Text(
            title,
            style: AppTextStyles.font18Medium.copyWith(color: AppColor.black),
          ),
          const Spacer(),
          Text(value, style: AppTextStyles.font16Bold),
        ],
      ),
    );
  }
}
