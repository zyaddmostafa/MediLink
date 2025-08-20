import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
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
      listener: (context, state) {
        if (state is StoreAppointmentLoading) {
          log('StoreAppointmentListener: Showing loading dialog');
          CustomDialog.showLoadingDialog(context: context);
        } else if (state is StoreAppointmentSuccess) {
          log('StoreAppointmentListener: Store appointment success');
          Navigator.of(context).pop(); // Close loading dialog

          if (context.mounted) {
            // Show success dialog
            CustomDialog.showSuccessDialog(
              context: context,
              title: 'Appointment Confirmed',
              message:
                  'Your appointment with Dr. ${appointmentDetails.doctorName} has been confirmed successfully!',
              buttonText: 'Go to Home',
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
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
              },
            );
          }
        } else if (state is StoreAppointmentFailure) {
          log(
            'StoreAppointmentListener - Failure state received: ${state.errorMessage}',
          );
          // Close loading dialog if open
          Navigator.of(context).pop();
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
