import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/presentation/widgets/doctors/doctors_card.dart';

class UpcomingAppointmentListItem extends StatelessWidget {
  final String appointmentsDate;
  const UpcomingAppointmentListItem({
    super.key,
    required this.appointmentsDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(appointmentsDate, style: AppTextStyles.font18Bold),
        verticalSpacing(12),
        // Add your appointment list here
        Column(
          children: List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: DoctorsCard(
                buttonProperties: ButtonPropertiesModel(
                  text: 'Cancel Appointment',
                  textColor: AppColor.primary,
                  backgroundColor: AppColor.doctorCardButton,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
