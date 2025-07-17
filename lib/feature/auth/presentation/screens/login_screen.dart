import 'package:doctor_appoinment/core/helpers/extentions.dart';
import 'package:doctor_appoinment/core/helpers/spacing.dart';
import 'package:doctor_appoinment/core/routing/routes.dart';
import 'package:doctor_appoinment/core/widgets/custom_elevated_button.dart';
import 'package:doctor_appoinment/core/widgets/custom_text_from_field.dart';
import 'package:doctor_appoinment/core/widgets/label_and_text_filed.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_header.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_rich_text.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/password_text_from_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(48),
              AuthHeader(title: 'Login'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(80),
                      _signinTextFields(),
                      verticalSpacing(32),
                      _signinElevatedButton(),
                      verticalSpacing(32),
                      _dontHaveAnAccountRichText(context),
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

  CustomElevatedButton _signinElevatedButton() {
    return CustomElevatedButton(
      text: 'Login',
      onPressed: () {
        // Handle login action
      },
    );
  }

  Center _dontHaveAnAccountRichText(BuildContext context) {
    return Center(
      child: AuthRichText(
        text: 'Don\'t have an account? ',
        linkText: 'Sign Up',
        onTap: () {
          context.pushReplacementNamed(Routes.signUpScreen);
        },
      ),
    );
  }
}

Widget _signinTextFields() {
  return Column(
    children: [
      LabelAndTextField(
        label: 'Email Address',
        textFormField: CustomTextFromField(hintText: 'Enter your email'),
      ),
      verticalSpacing(24),
      LabelAndTextField(
        label: 'Password',
        textFormField: PasswordTextFormField(hintText: 'Enter your password'),
      ),
    ],
  );
}
