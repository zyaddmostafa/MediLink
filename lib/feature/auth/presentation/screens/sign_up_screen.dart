import 'dart:developer';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/gender_selection_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/gender_selection_widget.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_screen_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Gender? selectedGender;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              verticalSpacing(28),
              const AuthHeader(title: 'Sign Up'),
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      verticalSpacing(50),
                      _nameAndEmailAndPhone(),
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

  Widget _nameAndEmailAndPhone() {
    return SignupScreenForm(
      formKey: _formKey,
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
    );
  }

  void validateThenDoSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Create signup data object to pass
      final signupData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'gender': GenderSelectionHelper.selectedGender(selectedGender),
      };

      context.pushNamed(Routes.setPasswordScreen, arguments: signupData);
    }
  }
}
