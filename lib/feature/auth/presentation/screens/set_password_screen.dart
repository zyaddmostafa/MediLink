import 'package:doctor_appoinment/core/helpers/extentions.dart';
import 'package:doctor_appoinment/core/helpers/spacing.dart';
import 'package:doctor_appoinment/core/routing/routes.dart';
import 'package:doctor_appoinment/core/widgets/custom_app_bar.dart';
import 'package:doctor_appoinment/core/widgets/custom_elevated_button.dart';
import 'package:doctor_appoinment/core/widgets/label_and_text_filed.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_header.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_rich_text.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/password_text_from_field.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              CustomAppBar(),
              verticalSpacing(20),
              AuthHeader(title: 'Set Password'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpacing(80),
                      _passwordTextFormField(),
                      verticalSpacing(32),
                      _signupElevatedButton(context),
                      verticalSpacing(32),
                      _alreadyHaveAnAccountRichText(context),
                      verticalSpacing(32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _alreadyHaveAnAccountRichText(BuildContext context) {
    return Center(
      child: AuthRichText(
        text: 'Already have an account? ',
        linkText: 'Login',
        onTap: () {
          context.pushAndRemoveUntil(Routes.loginScreen);
        },
      ),
    );
  }

  CustomElevatedButton _signupElevatedButton(context) =>
      CustomElevatedButton(text: 'Sign Up', onPressed: () {});
}

Widget _passwordTextFormField() {
  return Column(
    children: [
      LabelAndTextField(
        label: 'Password',
        textFormField: PasswordTextFormField(hintText: 'Enter your password'),
      ),
      verticalSpacing(24),
      LabelAndTextField(
        label: 'Confirm Password',
        textFormField: PasswordTextFormField(
          hintText: 'Re-enter your password',
        ),
      ),
    ],
  );
}
