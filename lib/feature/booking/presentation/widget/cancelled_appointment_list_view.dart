import 'package:flutter/material.dart';

import '../../../home/data/model/doctor_model.dart';
import '../../data/local/cancle_appoinmets_local_service.dart';
import '../../data/model/appoitmnet_data.dart';
import 'cancelled_doctors_list_view.dart';

class CancelledAppointmentListView extends StatelessWidget {
  final List<DoctorModel> cancelledDoctors;
  final List<AppointmentData> cancelledAppointments;
  const CancelledAppointmentListView({
    super.key,
    required this.cancelledDoctors,
    required this.cancelledAppointments,
  });

  @override
  Widget build(BuildContext context) {
    return CancelledDoctorsListView(
      cancelledDoctors:
          CancelledAppointmentsLocalService.getCancelledDoctorsByAppointments(
            cancelledAppointments,
          ),
      cancelledAppointments: cancelledAppointments,

      shrinkWrap: false,
    );
  }
}
