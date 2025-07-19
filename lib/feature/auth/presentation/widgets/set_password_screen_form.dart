import 'package:flutter/material.dart';

import '../../../../core/helpers/form_validaor.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import 'password_text_from_field.dart';

class SetPasswordScreenForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmation;
  final GlobalKey<FormState> formKey;
  const SetPasswordScreenForm({
    super.key,
    required this.passwordController,
    required this.passwordConfirmation,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Password',
            textFormField: PasswordTextFormField(
              hintText: 'Enter your password',
              controller: passwordController,
              validator: (value) {
                return FormValidators.validatePassword(value);
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Confirm Password',
            textFormField: PasswordTextFormField(
              hintText: 'Re-enter your password',
              controller: passwordConfirmation,
              validator: (value) {
                return FormValidators.validateConfirmPassword(
                  value,
                  passwordController.text,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
