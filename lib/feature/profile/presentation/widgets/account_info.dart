import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../data/local/user_local_service.dart';
import 'account_info_item.dart';
import 'logout_bloc_listener.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<UserLocalService>().getUser();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account Information', style: AppTextStyles.font16Bold),
        verticalSpacing(16),
        Column(
          spacing: 16,
          children: [
            AccountInfoItem(
              title: 'Name',
              value: user?.name ?? 'No name available',
              icon: Icons.person,
            ),

            AccountInfoItem(
              title: 'Email',
              value: user?.email ?? 'No email available',
              icon: Icons.email,
            ),

            AccountInfoItem(
              title: 'Phone',
              value: user?.phone ?? 'No phone available',
              icon: Icons.phone,
            ),

            AccountInfoItem(
              title: 'Gender',
              value: user?.gender ?? 'No gender available',
              icon: FontAwesomeIcons.marsAndVenus,
            ),

            AccountInfoItem(
              title: 'My Favorite',
              icon: FontAwesomeIcons.heart,
              onTap: () => context.pushNamed(Routes.favoriteScreen),
            ),
            AccountInfoItem(
              title: 'Sign Out',
              icon: FontAwesomeIcons.signOutAlt,
              iconColor: AppColor.red,
              textColor: AppColor.red,
              onTap: () {
                CustomDialog.showConfirmationDialog(
                  context: context,
                  title: 'Confirm Logout',
                  message:
                      'Are you sure you want to logout with ${user?.email ?? 'No Email available'} ? ',
                  confirmText: 'Logout',
                  onConfirm: () => context.read<AuthCubit>().logout(),
                );
              },
            ),
            const LogoutBlocListener(),
          ],
        ),
      ],
    );
  }
}
