import 'dart:developer';

import 'package:doctor_appoinment/core/helpers/extentions.dart';
import 'package:doctor_appoinment/core/helpers/spacing.dart';
import 'package:doctor_appoinment/core/routing/routes.dart';
import 'package:doctor_appoinment/core/widgets/custom_elevated_button.dart';
import 'package:doctor_appoinment/core/widgets/custom_text_from_field.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/gender_selection_widget.dart';
import 'package:doctor_appoinment/core/widgets/label_and_text_filed.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_header.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/auth_rich_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacing(48),
              AuthHeader(title: 'Sign Up'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpacing(80),
                      _signupTextField(),
                      verticalSpacing(16),
                      _selectGender(),
                      verticalSpacing(32),
                      _continueToSetPasswordScreen(),
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

  CustomElevatedButton _continueToSetPasswordScreen() {
    return CustomElevatedButton(
      text: 'Continue',
      onPressed: () {
        context.pushNamed(Routes.setPasswordScreen, arguments: selectedGender);
      },
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

  GenderSelectionWidget _selectGender() {
    return GenderSelectionWidget(
      label: 'Gender',
      selectedGender: selectedGender,
      onGenderChanged: (gender) {
        // return gender from here;
        setState(() {
          selectedGender = gender;
        });
        log('Selected gender: $selectedGender');
      },
    );
  }

  Widget _signupTextField() {
    return Column(
      children: [
        LabelAndTextField(
          label: 'Email',
          textFormField: CustomTextFromField(hintText: 'Enter your email'),
        ),
        verticalSpacing(24),
        LabelAndTextField(
          label: 'Phone',
          textFormField: CustomTextFromField(
            hintText: 'Enter your phone number',
          ),
        ),
      ],
    );
  }
}
