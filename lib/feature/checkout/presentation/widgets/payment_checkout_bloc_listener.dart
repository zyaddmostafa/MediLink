import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../cubit/payment_checkout_cubit.dart';
import '../../data/helpers/payment_methods_handler.dart';
import '../../data/model/appointment_details_model.dart';

class PaymentCheckoutBlocListener extends StatelessWidget {
  final Widget child;
  final AppointmentDetailsModel appointmentDetails;

  const PaymentCheckoutBlocListener({
    super.key,
    required this.child,
    required this.appointmentDetails,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCheckoutCubit, PaymentCheckoutState>(
      listener: (context, state) {
        switch (state) {
          case PaymentCheckoutLoading():
            CustomDialog.showLoadingDialog(
              context: context,
              message: 'Processing payment...',
            );
            break;
          case PaymentCheckoutNavigateToGateway():
            context.pop();
            PaymentMethodsHandler.navigateToPaymentGateway(
              context: context,
              state: state,
              appointmentDetails: appointmentDetails,
            );
            break;

          default:
            null;
        }
      },
      child: child,
    );
  }
}
