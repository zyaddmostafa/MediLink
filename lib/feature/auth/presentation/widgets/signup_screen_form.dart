import 'package:flutter/material.dart';

import '../../../../core/helpers/form_validaor.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';

class SignupScreenForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  const SignupScreenForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndTextField(
            label: 'Name',
            textFormField: CustomTextFromField(
              hintText: 'Enter your name',
              controller: nameController,
              validator: (value) {
                return FormValidators.validateName(value);
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Email',
            textFormField: CustomTextFromField(
              hintText: 'Enter your email',
              controller: emailController,
              validator: (value) {
                return FormValidators.validateEmail(value);
              },
            ),
          ),
          verticalSpacing(24),
          LabelAndTextField(
            label: 'Phone',
            textFormField: CustomTextFromField(
              hintText: 'Enter your phone number with country code',
              controller: phoneController,
              validator: (value) {
                return FormValidators.validatePhone(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
