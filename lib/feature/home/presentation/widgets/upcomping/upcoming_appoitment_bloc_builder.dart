import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helpers/skeletonizer_dummy_data.dart';
import '../../../../../core/widgets/error_state_widget.dart';
import '../../../../booking/presentation/cubit/booking_appointment_cubit.dart';
import 'upcoming_appointments_section.dart';

class UpComingAppoitmentBlocBuilder extends StatelessWidget {
  const UpComingAppoitmentBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>(
      buildWhen: (previous, current) =>
          current is GetStoredAppointmentsLoading ||
          current is GetStoredAppointmentsSuccess ||
          current is GetStoredAppointmentsFailure,
      builder: (context, state) {
        if (state is GetStoredAppointmentsLoading) {
          return Skeletonizer(
            enabled: true,
            child: UpcomingAppointmentsSection(
              appointments: SkeletonizerDummyData.dummyAppointmentsList,
            ),
          );
        } else if (state is GetStoredAppointmentsSuccess) {
          return UpcomingAppointmentsSection(appointments: state.response);
        } else if (state is GetStoredAppointmentsFailure) {
          return ErrorStateWidget(
            errorMessages: state.error.errors ?? {},
            errorMessage: state.error.message,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
