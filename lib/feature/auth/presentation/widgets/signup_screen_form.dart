import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../cubit/signup/signup_cubit.dart';

class SignupScreenForm extends StatelessWidget {
  const SignupScreenForm({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().emailAndPhoneFormKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Name',
            textFormField: CustomTextFromField(
              hintText: 'Enter your name',
              controller: context.read<SignupCubit>().nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Email',
            textFormField: CustomTextFromField(
              hintText: 'Enter your email',
              controller: context.read<SignupCubit>().emailController,
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
              controller: context.read<SignupCubit>().phoneNumberController,
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
}
