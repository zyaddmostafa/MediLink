import 'package:flutter/material.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../home/presentation/widgets/doctors/doctors_list_view.dart';
import '../../data/local/cancle_appoinmets_local_service.dart';

class CancelledAppointmentListView extends StatelessWidget {
  const CancelledAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return DoctorListView(
      isFavorite: false,
      doctors: CancelledAppointmentsLocalService.getCancelledAppointments(),
      buttonProperties: ButtonPropertiesModel(
        text: 'Reschedule ',
        textColor: AppColor.white,
        backgroundColor: AppColor.primary,
        onPressed: () {
          // Handle reschedule appointment action
        },
      ),
    );
  }
}
