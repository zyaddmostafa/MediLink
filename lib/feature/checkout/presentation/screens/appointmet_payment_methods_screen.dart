import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/store_appointment_listener.dart';
import '../../data/model/appointment_details_model.dart';
import '../../data/model/payment_method_helper.dart';
import '../../data/model/payment_utility.dart';
import '../../../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../widgets/cash_payment_confirmation_bottom_sheet.dart';
import '../widgets/payment_methods_list.dart';

class AppointmentPaymentMethodsScreen extends StatefulWidget {
  final AppointmentDetailsModel appointmentDetails;
  const AppointmentPaymentMethodsScreen({
    super.key,
    required this.appointmentDetails,
  });

  @override
  State<AppointmentPaymentMethodsScreen> createState() =>
      _AppointmentPaymentMethodsScreenState();
}

class _AppointmentPaymentMethodsScreenState
    extends State<AppointmentPaymentMethodsScreen> {
  String selectedPaymentMethod = 'visa'; // Default selection

  @override
  Widget build(BuildContext context) {
    return StoreAppointmentListener(
      appointmentDetails: widget.appointmentDetails,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    appBarwidget: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        'Payment Methods',
                        style: AppTextStyles.font16Bold,
                      ),
                    ),
                  ),
                  verticalSpacing(32),
                  Text('Select method', style: AppTextStyles.font18Bold),
                  verticalSpacing(24),

                  PaymentMethodsList(
                    selectedPaymentMethod: selectedPaymentMethod,
                    onPaymentMethodSelected: (paymentType) {
                      setState(() {
                        selectedPaymentMethod = paymentType;
                      });
                    },
                  ),
                  verticalSpacing(80),

                  CustomElevatedButton(
                    properties: ButtonPropertiesModel(
                      text: 'Continue',
                      textColor: AppColor.white,
                      backgroundColor: AppColor.primary,
                      onPressed: () => _handlePaymentContinue(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePaymentContinue(BuildContext context) async {
    log('Starting payment process for method: $selectedPaymentMethod');

    try {
      switch (selectedPaymentMethod) {
        case 'Cash':
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (bottomSheetContext) => BlocProvider.value(
              value: getIt<BookingAppointmentCubit>(),
              child: CashPaymentBottomSheet(
                appointmentDetails: widget.appointmentDetails,
              ),
            ),
          );

          break;
        default:
          if (PaymentMethodsHelper.isCardPayment(selectedPaymentMethod)) {
            await PaymentMethodsHelper.handleCardPayment(
              context,
              widget.appointmentDetails,
            );
          } else if (PaymentMethodsHelper.isMobileWalletSelected(
            selectedPaymentMethod,
          )) {
            await PaymentMethodsHelper.handleMobileWalletPayment(
              context,
              selectedPaymentMethod,
              widget.appointmentDetails.appointmentPrice,
              widget.appointmentDetails,
            );
          }
      }
    } catch (e) {
      log('Payment process error: $e');
      if (context.mounted) {
        await PaymentUtility.showPaymentError(
          context: context,
          title: 'Payment Error',
          message:
              'An error occurred during payment processing: ${e.toString()}',
        );
      }
    }
  }
}
