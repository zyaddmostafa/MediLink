import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../cubit/booking_appointment_cubit.dart';

class CancelAppointmentBlocListener extends StatelessWidget {
  const CancelAppointmentBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingAppointmentCubit, BookingAppointmentState>(
      listenWhen: (previous, current) =>
          current is CancelAppointmentLoading ||
          current is CancelAppointmentSuccess ||
          current is CancelAppointmentFailure,

      listener: (context, state) {
        log(
          'CancelAppointmentBlocListener: State changed to ${state.runtimeType}',
        );

        if (state is CancelAppointmentLoading) {
          log('CancelAppointmentBlocListener: Showing loading dialog');
          CustomDialog.showLoadingDialog(
            context: context,
            message: 'Cancelling appointment...',
          );
        } else if (state is CancelAppointmentSuccess) {
          context.pop(); // Close the loading dialog first

          log('CancelAppointmentBlocListener: Showing success dialog');
          // Show success dialog

          CustomDialog.showConfirmationDialog(
            context: context,
            title: 'Successfully',
            message: 'Appointment cancelled successfully',
            confirmText: 'Go to Home',
            onConfirm: () => context.pushNamed(Routes.mainNavigation),
          );
        } else if (state is CancelAppointmentFailure) {
          log(
            'CancelAppointmentBlocListener: Failure state received: ${state.errorMessage}',
          );
          // Close the loading dialog first
          Navigator.pop(context);

          // Show error snackbar
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
