import 'package:flutter/material.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../../../core/widgets/label_and_text_filed.dart';
import '../../../auth/presentation/widgets/password_text_from_field.dart';
import '../../data/local/user_local_service.dart';
import '../../data/model/user_response.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getIt<UserLocalService>().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final userinfo = snapshot.data!;
          return EditProfileFields(userinfo: userinfo);
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}

class EditProfileFields extends StatelessWidget {
  const EditProfileFields({super.key, required this.userinfo});

  final UserInformation userinfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelAndTextField(
          label: 'Name',
          textFormField: CustomTextFormField(hintText: userinfo.name),
        ),
        verticalSpacing(16),
        LabelAndTextField(
          label: 'Email',
          textFormField: CustomTextFormField(hintText: userinfo.email),
        ),

        verticalSpacing(16),
        LabelAndTextField(
          label: 'Phone',
          textFormField: CustomTextFormField(hintText: userinfo.phone),
        ),
        verticalSpacing(16),
        LabelAndTextField(
          label: 'Gender',
          textFormField: CustomTextFormField(hintText: userinfo.gender),
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
