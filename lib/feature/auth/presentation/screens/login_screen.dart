import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import '../widgets/password_text_from_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              const AuthHeader(title: 'Login'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(80),
                      _emailAndPassword(),
                      verticalSpacing(32),
                      _signinElevatedButton(),
                      verticalSpacing(32),
                      _dontHaveAnAccount(context),
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
        validateThenDoLogin(context);
      },
    );
  }

  Center _dontHaveAnAccount(BuildContext context) {
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

  Widget _emailAndPassword() {
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
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.pushReplacementNamed(Routes.signUpScreen);
    }
  }
}
