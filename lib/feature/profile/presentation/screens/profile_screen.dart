import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../widgets/account_info.dart';
import '../widgets/profile_screen_header.dart';
import '../widgets/user_image_and_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const ProfileSreenHeader(),
              verticalSpacing(32),
              const UserImageAndName(),
              verticalSpacing(42),
              const AccountInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
