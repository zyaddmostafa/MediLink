import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AppointmentDetailsHeader extends StatelessWidget {
  const AppointmentDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      appBarwidget: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text('Appointment Details', style: AppTextStyles.font16Bold),
      ),
    );
  }
}
