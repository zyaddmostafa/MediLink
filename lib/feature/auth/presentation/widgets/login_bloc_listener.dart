import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../cubit/auth_cubit.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginError ||
          current is LoginSuccess ||
          current is LoginLoading,
      listener: (context, state) {
        if (state is LoginError) {
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Login Error',
            message: state.apiErrorModel.getAllErrorMessages(),
          );
        } else if (state is LoginSuccess) {
          context.pushNamed(Routes.homeScreen);
        }
      },
      child: Container(),
    );
  }
}
