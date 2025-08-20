import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/store_appointment_listener.dart';
import '../../../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../../data/helpers/payment_methods_handler.dart';
import '../../data/model/appointment_details_model.dart';
import '../cubit/payment_checkout_cubit.dart';
import '../widgets/payment_methods_list.dart';
import '../widgets/payment_checkout_bloc_listener.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final AppointmentDetailsModel appointmentDetails;
  const PaymentMethodsScreen({super.key, required this.appointmentDetails});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selectedPaymentMethod = 'visa'; // Default selection

  @override
  Widget build(BuildContext context) {
    final bookingCubit = context.read<BookingAppointmentCubit>();
    final paymentCubit = context.read<PaymentCheckoutCubit>();

    return StoreAppointmentListener(
      appointmentDetails: widget.appointmentDetails,
      child: PaymentCheckoutBlocListener(
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
                        onPressed: () => _handlePaymentContinue(
                          context,
                          bookingCubit,
                          paymentCubit,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePaymentContinue(
    BuildContext context,
    BookingAppointmentCubit bookingCubit,
    PaymentCheckoutCubit paymentCubit,
  ) async {
    log(
      'PaymentMethodsScreen: Continue button pressed with method: $selectedPaymentMethod',
    );
    try {
      await PaymentMethodsHandler.handlePaymentContinue(
        context: context,
        selectedPaymentMethod: selectedPaymentMethod,
        appointmentDetails: widget.appointmentDetails,
        bookingCubit: bookingCubit,
        paymentCubit: paymentCubit,
      );
      log('PaymentMethodsScreen: Payment handler completed successfully');
    } catch (e) {
      log('Payment screen error: $e');
    }
  }
}
