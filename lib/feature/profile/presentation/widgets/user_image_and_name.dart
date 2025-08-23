import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/user_cubit.dart';

class UserImageAndName extends StatelessWidget {
  const UserImageAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesUser, height: 110.h),
        verticalSpacing(8),
        _userNameBlocBuilder(),
      ],
    );
  }

  BlocBuilder<UserCubit, UserState> _userNameBlocBuilder() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return Text(state.user.name, style: AppTextStyles.font18Bold);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
