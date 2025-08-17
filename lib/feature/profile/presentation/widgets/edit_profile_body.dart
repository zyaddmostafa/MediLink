import 'package:flutter/material.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../../../auth/presentation/widgets/password_text_from_field.dart';
import '../../data/local/user_local_service.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userinfo = getIt<UserLocalService>().getUser();
    return Column(
      children: [
        LabelAndTextField(
          label: 'Name',
          textFormField: CustomTextFormField(
            hintText: userinfo?.name ?? 'No name available',
          ),
        ),
        verticalSpacing(16),
        LabelAndTextField(
          label: 'Email',
          textFormField: CustomTextFormField(
            hintText: userinfo?.email ?? 'No email available',
          ),
        ),

        verticalSpacing(16),
        LabelAndTextField(
          label: 'Phone',
          textFormField: CustomTextFormField(
            hintText: userinfo?.phone ?? 'No phone available',
          ),
        ),
        verticalSpacing(16),
        LabelAndTextField(
          label: 'Gender',
          textFormField: CustomTextFormField(
            hintText: userinfo?.gender ?? 'No gender available',
          ),
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
