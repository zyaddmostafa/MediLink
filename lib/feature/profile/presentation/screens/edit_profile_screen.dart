import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(
                appBarwidget: Text(
                  'Account Information',
                  style: AppTextStyles.font16Bold,
                ),
              ),
              verticalSpacing(32),
              const Expanded(
                child: SingleChildScrollView(child: EditProfileBody()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
