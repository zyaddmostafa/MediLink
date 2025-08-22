import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import '../../../../core/helpers/extentions.dart';
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

      listener: (context, state) async {
        if (state is CancelAppointmentLoading) {
          _loadingDialog(context);
        } else if (state is CancelAppointmentSuccess) {
          _refreshTheFilterListAndShowSuccessDioalod(context);
        } else if (state is CancelAppointmentFailure) {
          _failureDialog(state, context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _loadingDialog(BuildContext context) {
    log('CancelAppointmentBlocListener: Showing loading dialog');
    CustomDialog.showLoadingDialog(
      context: context,
      message: 'Cancelling appointment...',
    );
  }

  void _failureDialog(CancelAppointmentFailure state, BuildContext context) {
    log(
      'CancelAppointmentBlocListener: Failure state received: ${state.errorMessage}',
    );
    // Close the loading dialog first
    CustomDialog.showErrorDialog(
      context: context,
      title: 'Error',
      message: state.errorMessage,
    );
  }

  void _refreshTheFilterListAndShowSuccessDioalod(BuildContext context) {
    context.pop(); // Close the loading dialog first

    log('CancelAppointmentBlocListener: Showing success dialog');
    // Refresh both upcoming and cancelled appointments
    context.read<BookingAppointmentCubit>().getFilteredAppointments();
    context.read<BookingAppointmentCubit>().getCancelledAppointments();

    CustomDialog.showSuccessDialog(
      context: context,
      title: 'Successfully',
      message: 'Appointment cancelled successfully',
      buttonText: 'OK',
    );
  }
}
