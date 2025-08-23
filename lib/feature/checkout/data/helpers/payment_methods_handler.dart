import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../../presentation/cubit/payment_checkout_cubit.dart';
import '../../presentation/widgets/cash_payment_confirmation_bottom_sheet.dart';
import '../model/appointment_details_model.dart';
import 'payment_utility.dart';

class PaymentMethodsHandler {
  /// Handle payment continue based on selected payment method
  static Future<void> handlePaymentContinue({
    required BuildContext context,
    required String selectedPaymentMethod,
    required AppointmentDetailsModel appointmentDetails,
    required BookingAppointmentCubit bookingCubit,
    required PaymentCheckoutCubit paymentCubit,
  }) async {
    try {
      // Generate temporary appointment ID from available data
      final appointmentId =
          'appt_${appointmentDetails.doctorId}_${appointmentDetails.appointmentDate.millisecondsSinceEpoch}';
      final amount = (appointmentDetails.appointmentPrice * 100)
          .toInt(); // Convert to cents/piastres

      log(
        'PaymentMethodsHandler: appointmentId: $appointmentId, amount: $amount',
      );

      switch (selectedPaymentMethod) {
        case 'Cash':
          log(
            'PaymentMethodsHandler: Processing Cash payment - calling _handleCashPayment',
          );
          await _handleCashPayment(
            context: context,
            appointmentDetails: appointmentDetails,
            bookingCubit: bookingCubit,
          );
          log('PaymentMethodsHandler: Cash payment handler completed');
          break;

        case 'visa':
        case 'Visa':
          log('PaymentMethodsHandler: Processing Visa payment');
          paymentCubit.processCardPayment(
            amount: amount,
            cardType: 'visa',
            appointmentId: appointmentId,
          );
          break;

        case 'mastercard':
        case 'Mastercard':
          log('PaymentMethodsHandler: Processing Mastercard payment');
          paymentCubit.processCardPayment(
            amount: amount,
            cardType: 'mastercard',
            appointmentId: appointmentId,
          );
          break;

        case 'vodafone_cash':
        case 'Vodafone Cash':
          await handleMobileWalletPayment(
            context: context,
            paymentCubit: paymentCubit,
            walletType: 'vodafone',
            walletName: 'Vodafone Cash',
            walletColor: const Color(0xFFE60023), // Vodafone red
            amount: amount,
            appointmentId: appointmentId,
          );
          break;

        case 'etisalat_cash':
        case 'Etisalat Cash':
          await handleMobileWalletPayment(
            context: context,
            paymentCubit: paymentCubit,
            walletType: 'etisalat',
            walletName: 'Etisalat Cash',
            walletColor: const Color(0xFF00A651), // Etisalat green
            amount: amount,
            appointmentId: appointmentId,
          );
          break;

        case 'orange_cash':
        case 'Orange Cash':
          await handleMobileWalletPayment(
            context: context,
            paymentCubit: paymentCubit,
            walletType: 'orange',
            walletName: 'Orange Cash',
            walletColor: const Color(0xFFFF6600), // Orange color
            amount: amount,
            appointmentId: appointmentId,
          );
          break;

        default:
          null;
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

  /// Handle cash payment with bottom sheet
  static Future<void> _handleCashPayment({
    required BuildContext context,
    required AppointmentDetailsModel appointmentDetails,
    required BookingAppointmentCubit bookingCubit,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: getIt<BookingAppointmentCubit>(),
        child: CashPaymentBottomSheet(
          appointmentDetails: appointmentDetails,
          bookingCubit: bookingCubit,
        ),
      ),
    );
  }

  /// Handle mobile wallet payment with number input dialog
  static Future<void> handleMobileWalletPayment({
    required BuildContext context,
    required PaymentCheckoutCubit paymentCubit,
    required String walletType,
    required String walletName,
    required Color walletColor,
    required int amount,
    required String appointmentId,
  }) async {
    // Show mobile number dialog
    final mobileNumber = await CustomDialog.showMobileNumberDialog(
      context: context,
      walletName: walletName,
      walletColor: walletColor,
    );

    // If user cancelled or didn't enter a number, return
    if (mobileNumber == null || mobileNumber.trim().isEmpty) {
      return;
    }

    // Validate mobile number (basic validation)
    if (!isValidMobileNumber(mobileNumber)) {
      if (context.mounted) {
        await PaymentUtility.showPaymentError(
          context: context,
          title: 'Invalid Mobile Number',
          message:
              'Please enter a valid mobile number (11 digits starting with 01)',
        );
      }
      return;
    }

    // Process the payment with the entered mobile number
    paymentCubit.processMobileWalletPayment(
      amount: amount,
      walletType: walletType,
      mobileNumber: mobileNumber.trim(),
      appointmentId: appointmentId,
    );
  }

  /// Navigate to the appropriate payment gateway based on payment type
  static Future<void> navigateToPaymentGateway({
    required BuildContext context,
    required PaymentCheckoutNavigateToGateway state,
    required AppointmentDetailsModel appointmentDetails,
  }) async {
    try {
      if (state.gatewayType == 'card' &&
          state.paymentToken != null &&
          state.paymentToken!.isNotEmpty) {
        // Navigate to card payment gateway
        await context.pushNamed(
          Routes.cardPaymentGetWay,
          arguments: {
            'paymentToken': state.paymentToken!,
            'appointmentDetails': appointmentDetails,
          },
        );
      } else if (state.gatewayType == 'wallet' &&
          state.redirectUrl != null &&
          state.redirectUrl!.isNotEmpty) {
        await context.pushNamed(
          Routes.paymobMobileGetway,
          arguments: {
            'webUri': state.redirectUrl!,
            'appointmentDetails': appointmentDetails,
            'walletType': 'wallet',
          },
        );
      }
    } catch (e) {
      log('PaymentMethodsHandler: Navigation error - $e');
      // Handle navigation errors
      if (context.mounted) {
        await PaymentUtility.showPaymentError(
          context: context,
          title: 'Navigation Error',
          message: 'Failed to open payment gateway: $e',
        );
      }
    }
  }

  /// Validate Egyptian mobile number format
  static bool isValidMobileNumber(String number) {
    // Remove any spaces or special characters
    final cleanNumber = number.replaceAll(RegExp(r'[^\d]'), '');

    // Check if it's 11 digits and starts with 01
    return cleanNumber.length == 11 && cleanNumber.startsWith('01');
  }
}
