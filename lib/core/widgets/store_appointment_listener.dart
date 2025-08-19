import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import '../helpers/extentions.dart';
import '../routing/routes.dart';
import '../widgets/custom_dioalog.dart';

class StoreAppointmentListener extends StatelessWidget {
  final AppointmentDetailsModel appointmentDetails;
  final Widget child;

  const StoreAppointmentListener({
    super.key,
    required this.appointmentDetails,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingAppointmentCubit, BookingAppointmentState>(
      listenWhen: (previous, current) {
        return current is StoreAppointmentLoading ||
            current is StoreAppointmentSuccess ||
            current is StoreAppointmentFailure;
      },
      listener: (context, state) {
        log(
          'StoreAppointmentListener - listener triggered with state: ${state.runtimeType}',
        );
        if (state is StoreAppointmentLoading) {
          log('StoreAppointmentListener - Loading state received');
          // // Show loading dialog
          // CustomDialog.showLoadingDialog(context: context);
        } else if (state is StoreAppointmentSuccess) {
          log(
            'StoreAppointmentListener - Success state received, showing dialog',
          );
          if (context.mounted) {
            log(
              'StoreAppointmentListener - Showing success dialog after delay',
            );
            // Show success dialog
            // CustomDialog.showConfirmationDialog(
            //   context: context,
            //   title: 'Payment Successful',
            //   message:
            //       'Your appointment with Dr. ${appointmentDetails.doctorName} has been confirmed successfully!',
            //   confirmText: 'Go to Home',
            //   onConfirm: () {
            //     // Navigate to home
            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //       Routes.mainNavigation,
            //       (route) => false,
            //     );
            //   },
            // );
          }
        } else if (state is StoreAppointmentFailure) {
          log(
            'StoreAppointmentListener - Failure state received: ${state.errorMessage}',
          );
          // Close loading dialog if open
          context.pop();
          // Show error dialog
          CustomDialog.showErrorDialog(
            context: context,
            title: 'Booking Failed',
            message: state.errorMessage,
            buttonText: 'Try Again',
            onPressed: () {
              // Use post-frame callback and delay for stable navigation
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    if (context.mounted) {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamedAndRemoveUntil(
                        Routes.mainNavigation,
                        (route) => false,
                      );
                    }
                  });
                }
              });
            },
          );
        }
      },
      child: child,
    );
  }
}
