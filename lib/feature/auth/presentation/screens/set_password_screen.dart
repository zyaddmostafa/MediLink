import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import '../widgets/password_text_from_field.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const CustomAppBar(),
              verticalSpacing(20),
              const AuthHeader(title: 'Set Password'),
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

  CustomElevatedButton _signupElevatedButton(context) => CustomElevatedButton(
    text: 'Sign Up',
    onPressed: () {
      validateThenDoSignUp(context);
    },
  );

  Widget _passwordTextFormField() {
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
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
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
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != passwordController.text) {
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

  void validateThenDoSignUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Navigate to login screen
      context.pushReplacementNamed(Routes.loginScreen);
    }
  }
}
