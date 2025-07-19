import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../cubit/login_cubit/login_cubit.dart';
import 'password_text_from_field.dart';

class LoginScreenForm extends StatelessWidget {
  const LoginScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Email Address',
            textFormField: CustomTextFromField(
              hintText: 'Enter your email',
              controller: context.read<LoginCubit>().emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Invalid email format';
                }
                return null;
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Password',
            textFormField: PasswordTextFormField(
              hintText: 'Enter your password',
              controller: context.read<LoginCubit>().passwordController,
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
        ],
      ),
    );
  }
}
