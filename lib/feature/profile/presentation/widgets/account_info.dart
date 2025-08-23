import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../data/model/user_response.dart';
import '../cubit/user_cubit.dart';
import 'account_info_item.dart';
import 'logout_bloc_listener.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account Information', style: AppTextStyles.font16Bold),
        verticalSpacing(16),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserSuccess) {
              return AccountInfoDetails(user: state.user);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class AccountInfoDetails extends StatelessWidget {
  final UserInformation user;
  const AccountInfoDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        AccountInfoItem(title: 'Name', value: user.name, icon: Icons.person),

        AccountInfoItem(title: 'Email', value: user.email, icon: Icons.email),

        AccountInfoItem(title: 'Phone', value: user.phone, icon: Icons.phone),

        AccountInfoItem(
          title: 'Gender',
          value: user.gender,
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
              message: 'Are you sure you want to logout with ${user.email} ? ',
              confirmText: 'Logout',
              onConfirm: () => context.read<AuthCubit>().logout(),
            );
          },
        ),
        const LogoutBlocListener(),
      ],
    );
  }
}
