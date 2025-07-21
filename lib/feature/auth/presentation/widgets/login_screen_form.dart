import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/form_validaor.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import 'password_text_from_field.dart';

class LoginScreenForm extends StatelessWidget {
  const LoginScreenForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Email Address',
            textFormField: CustomTextFromField(
              hintText: 'Enter your email',
              controller: emailController,
              validator: (value) {
                return FormValidators.validateEmail(value);
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Password',
            textFormField: PasswordTextFormField(
              hintText: 'Enter your password',
              controller: passwordController,
              validator: (value) {
                if (value.isNullOrEmpty()) {
                  return 'Password cannot be empty';
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
