import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import '../widgets/login_bloc_listener.dart';
import '../widgets/login_screen_form.dart';
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
              const AuthHeader(title: 'Login'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(50),
                      _emailAndPassword(context),
                      verticalSpacing(32),
                      _loginElevatedButton(context),
                      verticalSpacing(32),
                      _dontHaveAnAccount(context),
                      verticalSpacing(32),
                      const LoginBlocListener(),
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

  CustomElevatedButton _loginElevatedButton(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();
    return CustomElevatedButton(
      text: 'Login',
      onPressed: () {
        validateThenDoLogin(context);
      },
      isLoading: loginCubit is LoginLoading,
    );
  }

  Center _dontHaveAnAccount(BuildContext context) {
    return Center(
      child: AuthRichText(
        text: 'Don\'t have an account? ',
        linkText: 'Sign Up',
        onTap: () {
          context.pushNamed(Routes.signUpScreen);
        },
      ),
    );
  }

  Widget _emailAndPassword(BuildContext context) {
    return const LoginScreenForm();
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().login();
    }
  }
}
