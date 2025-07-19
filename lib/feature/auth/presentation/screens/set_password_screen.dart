import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../cubit/signup/signup_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import 'package:flutter/material.dart';

import '../widgets/set_password_screen_form.dart';
import '../widgets/signup_bloc_listener.dart';

class SetPasswordScreen extends StatelessWidget {
  final int gender;
  const SetPasswordScreen({super.key, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const CustomAppBar(),
              verticalSpacing(28),
              const AuthHeader(title: 'Set Password'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpacing(80),
                      _passwordTextFormField(context),
                      verticalSpacing(32),
                      _signupElevatedButton(context),
                      verticalSpacing(32),
                      _alreadyHaveAnAccountRichText(context),
                      verticalSpacing(32),
                    ],
                  ),
                ),
              ),
              const SignupBlocListener(),
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

  CustomElevatedButton _signupElevatedButton(BuildContext context) {
    final signupCubit = context.watch<SignupCubit>();
    return CustomElevatedButton(
      text: 'Sign Up',
      onPressed: () {
        validateThenDoSignUp(context);
      },
      isLoading: signupCubit.state is SignupLoading,
    );
  }

  Widget _passwordTextFormField(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();
    return SetPasswordScreenForm(signupCubit: signupCubit);
  }

  void validateThenDoSignUp(BuildContext context) {
    final signupCubit = context.read<SignupCubit>();
    if (signupCubit.passwordsFormKey.currentState!.validate()) {
      signupCubit.signup(gender);
    }
  }
}
