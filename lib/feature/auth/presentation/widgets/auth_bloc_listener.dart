import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../cubit/auth_cubit.dart';

class AuthBlocListener extends StatelessWidget {
  const AuthBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is LoginError ||
          current is LoginSuccess ||
          current is LoginLoading ||
          current is SignupError ||
          current is SignupSuccess ||
          current is SignupLoading,
      listener: (context, state) {
        switch (state) {
          case LoginError():
            _showErrorDialog(
              context: context,
              title: 'Login Error',
              message: state.apiErrorModel.getAllErrorMessages(),
            );
            break;
          case LoginSuccess():
            _handleLoginSuccess(context);
            break;
          case SignupError():
            _showErrorDialog(
              context: context,
              title: 'Sign Up Error',
              message: state.apiErrorModel.getAllErrorMessages(),
            );
            break;
          case SignupSuccess():
            _showSuccessDialog(context);
            break;
          default:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  /// Shows error dialog for both login and signup errors
  void _showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    CustomDialog.showErrorDialog(
      context: context,
      title: title,
      message: message,
    );
  }

  /// Handles successful login by navigating to home screen
  void _handleLoginSuccess(BuildContext context) {
    context.pushNamed(Routes.homeScreen);
  }

  /// Shows success dialog for signup completion
  void _showSuccessDialog(BuildContext context) {
    CustomDialog.showSuccessDialog(
      context: context,
      title: 'Account Created!',
      message: 'Your account has been created successfully. You can now login.',
      buttonText: 'Go to Login',
      onPressed: () {
        context.pushAndRemoveUntil(Routes.loginScreen);
      },
    );
  }
}
