import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../home/data/model/doctor_model.dart';
import '../../../home/presentation/widgets/doctors/doctors_card.dart';
import '../../data/model/appoitmnet_data.dart';
import '../cubit/booking_appointment_cubit.dart';

class CanceledAppoitmenttListView extends StatelessWidget {
  final List<AppointmentData> cancelledAppointments;
  final List<DoctorModel> cancelledDoctors;
  final bool shrinkWrap; // Control shrinkWrap behavior
  final ButtonPropertiesModel? buttonProperties; // Optional button properties

  const CanceledAppoitmenttListView({
    super.key,
    required this.cancelledAppointments,
    required this.cancelledDoctors,
    this.shrinkWrap = false,
    this.buttonProperties,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => verticalSpacing(12),
      itemCount: cancelledDoctors.length,
      itemBuilder: (context, index) {
        return DoctorsCard(
          key: ValueKey(cancelledDoctors[index].id), // Unique key for each card
          doctor: cancelledDoctors[index],
          buttonProperties:
              buttonProperties ??
              ButtonPropertiesModel(
                text: 'Reschedule',
                textColor: AppColor.white,
                backgroundColor: AppColor.primary,
                onPressed: () {
                  context.read<BookingAppointmentCubit>().rescheduleAppointment(
                    cancelledAppointments[index].id,
                  );
                  context.pushNamed(
                    Routes.doctorInfo,
                    arguments: cancelledDoctors[index].id,
                  );
                },
              ),
        );
      },
    );
  }
}
