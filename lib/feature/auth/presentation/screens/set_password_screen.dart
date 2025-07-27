import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/models/sign_up_request_body.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import 'package:flutter/material.dart';

import '../widgets/set_password_screen_form.dart';
import '../widgets/auth_bloc_listener.dart';

class SetPasswordScreen extends StatefulWidget {
  final Map<String, dynamic> signupData;
  const SetPasswordScreen({super.key, required this.signupData});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
              const AuthBlocListener(),
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
    final signupCubit = context.watch<AuthCubit>();
    return CustomElevatedButton(
      text: 'Sign Up',
      onPressed: () {
        validateThenDoSignUp(context);
      },
      isLoading: signupCubit.state is SignupLoading,
    );
  }

  Widget _passwordTextFormField(BuildContext context) {
    return SetPasswordScreenForm(
      passwordController: passwordController,
      passwordConfirmation: passwordConfirmationController,
      formKey: _formKey,
    );
  }

  void validateThenDoSignUp(BuildContext context) {
    final signupCubit = context.read<AuthCubit>();
    if (_formKey.currentState!.validate()) {
      signupCubit.signup(
        SignupRequestBody(
          name: widget.signupData['name'],
          email: widget.signupData['email'],
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
          phone: widget.signupData['phone'],
          gender: widget.signupData['gender'],
        ),
      );
    }
  }
}
