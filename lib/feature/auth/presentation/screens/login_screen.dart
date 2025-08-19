import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/models/login_request_body.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_rich_text.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/login_screen_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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

                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: AppColor.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'OR',
                                  style: AppTextStyles.font14Medium,
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                          verticalSpacing(32),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialAuthItem(
                                svgImage: Assets.svgsGoogle,
                                onTap: () {},
                              ),
                              horizontalSpacing(24),
                              SocialAuthItem(
                                svgImage: Assets.svgsFacebook,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const AuthBlocListener(),
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
    final authCubit = context.watch<AuthCubit>();
    return CustomElevatedButton(
      properties: ButtonPropertiesModel(
        text: 'Login',
        textColor: AppColor.white,
        backgroundColor: AppColor.primary,
        onPressed: () {
          validateThenDoLogin(context);
        },
        isLoading: authCubit.state is LoginLoading,
      ),
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
    return LoginScreenForm(
      formKey: _formKey,
      emailController: emailController,
      passwordController: passwordController,
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}

class SocialAuthItem extends StatelessWidget {
  final String svgImage;
  final VoidCallback onTap;
  const SocialAuthItem({
    super.key,
    required this.svgImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const ShapeDecoration(
          color: AppColor.blueGrey,
          shape: OvalBorder(),
        ),
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(svgImage),
      ),
    );
  }
}
