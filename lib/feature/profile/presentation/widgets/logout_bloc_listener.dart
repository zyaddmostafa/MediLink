import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class LogoutBlocListener extends StatelessWidget {
  const LogoutBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is LogoutSuccess ||
          current is LogoutError ||
          current is LogoutLoading,
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.pop();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.pushAndRemoveUntil(Routes.loginScreen);
            }
          });
        } else if (state is LogoutError) {
          context.pop();
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Logout Failed',
            message: state.apiErrorModel.message ?? 'Unknown error in logout',
          );
        } else if (state is LogoutLoading) {
          CustomDialog.showLoadingDialog(
            context: context,
            message: 'Logging out...',
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
