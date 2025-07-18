import 'dart:developer';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../widgets/gender_selection_widget.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Gender? selectedGender = Gender.male;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              const AuthHeader(title: 'Sign Up'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpacing(80),
                      _emailAndPhone(),
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
        validateThenDoSignUp(context);
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

  Widget _emailAndPhone() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Email',
            textFormField: CustomTextFromField(
              hintText: 'Enter your email',
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Phone',
            textFormField: CustomTextFromField(
              hintText: 'Enter your phone number',
              controller: phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void validateThenDoSignUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.pushReplacementNamed(
        Routes.setPasswordScreen,
        arguments: selectedGender,
      );
    }
  }
}
