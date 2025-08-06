import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../data/model/appointment_details_model.dart';
import '../cubit/store_appointment_cubit.dart';
import 'card_payment_confirmation_bottom_sheet.dart';

class CashPaymentBottomSheetBlocListener extends StatelessWidget {
  final AppointmentDetailsModel appointmentDetails;
  const CashPaymentBottomSheetBlocListener({
    super.key,
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
          log('Cash payment successful');
          Navigator.pop(context); // Close the bottom sheet
          CustomDialog.showConfirmationDialog(
            context: context,
            title: 'Payment Successful',
            message:
                'Your appointment with Dr. ${appointmentDetails.doctorName} has been confirmed successfully!',
            confirmText: 'Go to Home',
            onConfirm: () => context.pushAndRemoveUntil(Routes.mainNavigation),
          );
        }
      },
      child: CashPaymentBottomSheet(
        appointmentDetails: appointmentDetails,
        storeAppointmentCubit: context.read<StoreAppointmentCubit>(),
      ),
    );
  }
}
