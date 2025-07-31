import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widget/appointment_tab_bar_view.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text('Appointments', style: AppTextStyles.font16Bold),

              verticalSpacing(24),

              const Expanded(child: AppointmentTabBarView()),
            ],
          ),
        ),
      ),
    );
  }
}
