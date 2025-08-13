import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../../../auth/presentation/widgets/password_text_from_field.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LabelAndTextField(
          label: 'Name',
          textFormField: CustomTextFormField(hintText: 'Zyad mostafa'),
        ),
        verticalSpacing(16),
        const LabelAndTextField(
          label: 'Email',
          textFormField: CustomTextFormField(hintText: 'zyad@example.com'),
        ),

        verticalSpacing(16),
        const LabelAndTextField(
          label: 'Phone',
          textFormField: CustomTextFormField(hintText: '0123456789'),
        ),
        verticalSpacing(16),
        const LabelAndTextField(
          label: 'Gender',
          textFormField: CustomTextFormField(hintText: 'Male'),
        ),
        verticalSpacing(16),
        LabelAndTextField(
          label: 'Password',
          textFormField: PasswordTextFormField(
            hintText: '********',
            controller: TextEditingController(),
          ),
        ),
        verticalSpacing(32),
        CustomElevatedButton(
          properties: ButtonPropertiesModel(
            isLoading: false,
            onPressed: () {},
            text: 'Save Changes',
          ),
        ),
        verticalSpacing(16),
      ],
    );
  }
}
