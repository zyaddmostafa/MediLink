import 'package:flutter/material.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../cubit/signup/signup_cubit.dart';
import 'password_text_from_field.dart';

class SetPasswordScreenForm extends StatelessWidget {
  const SetPasswordScreenForm({super.key, required this.signupCubit});

  final SignupCubit signupCubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupCubit.passwordsFormKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Password',
            textFormField: PasswordTextFormField(
              hintText: 'Enter your password',
              controller: signupCubit.passwordController,
              validator: (value) {
                if (value!.isNullOrEmpty()) {
                  return 'Please confirm your password';
                }
                if (!AppRegex.isValidPassword(value)) {
                  return 'Password must contain at least one uppercase letter, one \n lowercase letter, one number, and one special character';
                }
                return null;
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Confirm Password',
            textFormField: PasswordTextFormField(
              hintText: 'Re-enter your password',
              controller: signupCubit.passwordConfirmation,
              validator: (value) {
                if (value!.isNullOrEmpty()) {
                  return 'Please confirm your password';
                }

                if (value != signupCubit.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
