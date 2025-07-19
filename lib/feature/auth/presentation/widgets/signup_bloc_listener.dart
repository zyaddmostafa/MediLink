import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../cubit/signup/signup_cubit.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupError) {
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Sign Up Error',
            message: state.apiErrorModel.getAllErrorMessages(),
          );
        } else if (state is SignupSuccess) {
          CustomDialog.showSuccessDialog(
            context: context,
            title: 'Account Created!',
            message:
                'Your account has been created successfully. You can now login.',
            buttonText: 'Go to Login',
            onPressed: () {
              context.pushAndRemoveUntil(Routes.loginScreen);
            },
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
