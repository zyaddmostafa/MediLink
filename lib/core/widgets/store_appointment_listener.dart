import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/checkout/presentation/cubit/store_appointment_cubit.dart';
import '../helpers/extentions.dart';
import '../routing/routes.dart';
import '../widgets/custom_dioalog.dart';

class StoreAppointmentListener extends StatelessWidget {
  final Widget child;
  final AppointmentDetailsModel appointmentDetails;

  const StoreAppointmentListener({
    super.key,
    required this.child,
    required this.appointmentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreAppointmentCubit, StoreAppointmentState>(
      listener: (context, state) {
        if (state is StoreAppointmentLoading) {
          CustomDialog.showLoadingDialog(
            context: context,
            message: 'Storing your appointment...',
          );
        } else if (state is StoreAppointmentSuccess) {
          // Hide loading dialog
          Navigator.pop(context);

          // Show success confirmation dialog
          CustomDialog.showConfirmationDialog(
            context: context,
            title: 'Payment Successful',
            message:
                'Your appointment with Dr. ${appointmentDetails.doctorName} has been confirmed successfully!',
            confirmText: 'Go to Home',
            onConfirm: () {
              context.pushAndRemoveUntil(Routes.mainNavigation);
            },
          );
        } else if (state is StoreAppointmentFailure) {
          // Hide loading dialog
          Navigator.pop(context);

          // Show error dialog
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Booking Failed',
            message: state.errorMessage,
            buttonText: 'Try Again',
            onPressed: () {
              Navigator.pop(context, {'status': 'failed'});
            },
          );
        }
      },
      child: child,
    );
  }
}
