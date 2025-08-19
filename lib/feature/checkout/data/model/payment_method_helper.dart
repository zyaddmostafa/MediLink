import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/paymob/paymob_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../presentation/widgets/cash_payment_confirmation_bottom_sheet.dart';
import 'appointment_details_model.dart';
import 'payment_utility.dart';

/// Model representing a payment method with its details
class PaymentMethodModel {
  final String paymentType;
  final String title;
  final String iconAsset;

  const PaymentMethodModel({
    required this.paymentType,
    required this.title,
    required this.iconAsset,
  });
}

/// Helper class for handling different payment methods
class PaymentMethodsHelper {
  // Private constructor to prevent instantiation
  PaymentMethodsHelper._();

  static const List<PaymentMethodModel> paymentMethods = [
    PaymentMethodModel(
      paymentType: 'visa',
      title: 'Visa Card',
      iconAsset: Assets.svgsVisa,
    ),
    PaymentMethodModel(
      paymentType: 'mastercard',
      title: 'Mastercard',
      iconAsset: Assets.svgsMastercard,
    ),
    PaymentMethodModel(
      paymentType: 'Cash',
      title: 'Cash',
      iconAsset: Assets.svgsCashPaySvgrepoCom,
    ),
    PaymentMethodModel(
      paymentType: 'Vodafone Cash',
      title: 'Vodafone Cash',
      iconAsset: Assets.svgsVodafoneIcon,
    ),
    PaymentMethodModel(
      paymentType: 'Etisalat Cash',
      title: 'Etisalat Cash',
      iconAsset: Assets.svgsEtisalatAndLogo,
    ),
    PaymentMethodModel(
      paymentType: 'Orange Cash',
      title: 'Orange Cash',
      iconAsset: Assets.svgsOrange3,
    ),
  ];

  // Payment method type constants
  static const String _cardVisa = 'visa';
  static const String _cardMastercard = 'mastercard';
  static const String _cash = 'Cash';
  static const String _vodafoneCash = 'Vodafone Cash';
  static const String _etisalatCash = 'Etisalat Cash';
  static const String _orangeCash = 'Orange Cash';

  /// Main entry point for processing any payment method
  static Future<void> processPayment({
    required BuildContext context,
    required String selectedPaymentMethod,
    required AppointmentDetailsModel appointmentDetails,
  }) async {
    if (!context.mounted) return;

    try {
      if (isCashPayment(selectedPaymentMethod)) {
        await handleCashPayment(context, appointmentDetails);
      } else if (isCardPayment(selectedPaymentMethod)) {
        await handleCardPayment(context, appointmentDetails);
      } else if (isMobileWalletSelected(selectedPaymentMethod)) {
        await handleMobileWalletPayment(
          context,
          selectedPaymentMethod,
          appointmentDetails.appointmentPrice,
          appointmentDetails,
        );
      } else {
        log('Unknown payment method: $selectedPaymentMethod');
        await _showErrorDialog(
          context,
          'Invalid Payment Method',
          'The selected payment method is not supported.',
        );
      }
    } catch (e) {
      log('Error processing payment: $e');
      if (context.mounted) {
        await _showErrorDialog(
          context,
          'Payment Error',
          'An error occurred while processing your payment. Please try again.',
        );
      }
    }
  }

  /// Handles cash payment by showing bottom sheet
  static Future<void> handleCashPayment(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    try {
      log('Processing cash payment...');

      if (!context.mounted) return;

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) =>
            CashPaymentBottomSheet(appointmentDetails: appointmentDetails),
      );
    } catch (e) {
      log('Error in cash payment: $e');
      if (context.mounted) {
        await _showErrorDialog(
          context,
          'Cash Payment Error',
          'Unable to process cash payment. Please try again.',
        );
      }
    }
  }

  /// Handles card payment (Visa/Mastercard)
  static Future<void> handleCardPayment(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    if (!context.mounted) return;

    log('Processing card payment...');

    return PaymentUtility.executeWithLoading(
      context: context,
      loadingMessage: 'Processing payment...',
      action: () => _processCardPayment(context, appointmentDetails),
      errorTitle: 'Card Payment Failed',
      errorMessage: 'Unable to process card payment',
    );
  }

  /// Handles mobile wallet payments (Vodafone, Etisalat, Orange Cash)
  static Future<void> handleMobileWalletPayment(
    BuildContext context,
    String selectedPaymentMethod,
    int appointmentPrice,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    if (!context.mounted) return;

    try {
      final mobileNumber = await _getMobileNumberFromUser(
        context,
        selectedPaymentMethod,
      );

      if (mobileNumber == null || mobileNumber.trim().isEmpty) {
        log('Mobile wallet payment cancelled or empty number provided');
        return;
      }

      if (!context.mounted) return;

      await _processWalletPayment(
        context: context,
        selectedPaymentMethod: selectedPaymentMethod,
        appointmentPrice: appointmentPrice,
        appointmentDetails: appointmentDetails,
        mobileNumber: mobileNumber.trim(),
      );
    } catch (e) {
      log('Error in mobile wallet payment: $e');
      if (context.mounted) {
        await _showErrorDialog(
          context,
          'Mobile Wallet Payment Failed',
          'Unable to process $selectedPaymentMethod payment: ${e.toString()}',
        );
      }
    }
  }

  /// Gets mobile number from user for wallet payment
  static Future<String?> _getMobileNumberFromUser(
    BuildContext context,
    String selectedPaymentMethod,
  ) async {
    if (!context.mounted) return null;

    try {
      final result = await CustomDialog.showMobileNumberDialog(
        context: context,
        walletName: selectedPaymentMethod,
        walletColor: AppColor.primary,
      );
      return result;
    } catch (e) {
      log('Error getting mobile number: $e');
      return null;
    }
  }

  /// Processes card payment through PayMob
  static Future<void> _processCardPayment(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    if (!context.mounted) return;

    final paymobManager = PaymobManager();
    final paymentKey = await paymobManager.payWithPaymob(
      amount: appointmentDetails.appointmentPrice,
    );

    if (context.mounted) {
      await context.pushNamed(
        Routes.paymentGetWay,
        arguments: {
          'paymentToken': paymentKey,
          'appointmentDetails': appointmentDetails,
        },
      );
    }
  }

  /// Processes mobile wallet payment
  static Future<void> _processWalletPayment({
    required BuildContext context,
    required String selectedPaymentMethod,
    required int appointmentPrice,
    required AppointmentDetailsModel appointmentDetails,
    required String mobileNumber,
  }) async {
    if (!context.mounted) return;

    return PaymentUtility.executeWithLoading(
      context: context,
      loadingMessage: 'Processing $selectedPaymentMethod payment...',
      action: () => _executeWalletPayment(
        context: context,
        selectedPaymentMethod: selectedPaymentMethod,
        appointmentPrice: appointmentPrice,
        appointmentDetails: appointmentDetails,
        mobileNumber: mobileNumber,
      ),
      errorTitle: 'Mobile Wallet Payment Failed',
      errorMessage: 'Unable to process $selectedPaymentMethod payment',
    );
  }

  /// Executes the actual wallet payment process
  static Future<void> _executeWalletPayment({
    required BuildContext context,
    required String selectedPaymentMethod,
    required int appointmentPrice,
    required AppointmentDetailsModel appointmentDetails,
    required String mobileNumber,
  }) async {
    if (!context.mounted) return;

    final paymobManager = PaymobManager();
    final redirectUrl = await paymobManager.mobileWalletPayment(
      amount: appointmentPrice,
      walletMobileNumber: mobileNumber,
    );

    if (!context.mounted) return;

    final result = await context.pushNamed(
      Routes.paymobMobileGetway,
      arguments: {
        'webUri': redirectUrl,
        'walletType': selectedPaymentMethod.toLowerCase(),
        'appointmentDetails': appointmentDetails,
      },
    );

    if (!context.mounted) return;

    await _handlePaymentResult(context, result, appointmentDetails);
  }

  /// Handles the payment result from WebView
  static Future<void> _handlePaymentResult(
    BuildContext context,
    Object? result,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    if (!context.mounted) return;

    if (result is Map<String, dynamic>) {
      final status = result['status'];
      if (status == 'success') {
        log('Payment successful');
        // Add a small delay to ensure any ongoing operations complete
        await Future.delayed(const Duration(milliseconds: 100));
        if (context.mounted) {
          await _showSuccessDialog(context, appointmentDetails);
        }
      } else if (status == 'error' || status == 'failed') {
        log('Payment failed: ${result['message']}');
        await _showErrorDialog(
          context,
          'Payment Failed',
          result['message'] ?? 'Payment failed',
        );
      }
    }
  }

  /// Shows success dialog after successful payment
  static Future<void> _showSuccessDialog(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    log('Showing success dialog from PaymentMethodHelper');
    if (!context.mounted) return;

    // Use a simple custom dialog that properly handles navigation
    await CustomDialog.showConfirmationDialog(
      context: context,
      title: 'Payment Successful',
      message:
          'Your appointment with Dr. ${appointmentDetails.doctorName} '
          'has been confirmed successfully!',
      confirmText: 'Go to Home',
      onConfirm: () {
        if (context.mounted) {
          _navigateToHome(context);
        }
      },
    );
  }

  /// Shows error dialog for payment failures
  static Future<void> _showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    if (!context.mounted) return;

    await PaymentUtility.showPaymentError(
      context: context,
      title: title,
      message: message,
      buttonText: 'Try Again',
    );
  }

  /// Navigates to home screen after successful payment
  static void _navigateToHome(BuildContext context) {
    if (!context.mounted) return;

    log('Attempting navigation to home...');

    // Use a more direct approach with error handling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      try {
        log('Executing navigation to main navigation...');
        context.pushAndRemoveUntil(Routes.mainNavigation);
      } catch (e) {
        log('Navigation failed with error: $e');
        // Try alternative navigation
        try {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(Routes.mainNavigation, (route) => false);
        } catch (e2) {
          log('Fallback navigation also failed: $e2');
        }
      }
    });
  }

  /// Checks if the selected payment method is a card payment
  static bool isCardPayment(String selectedPaymentMethod) {
    return selectedPaymentMethod == _cardVisa ||
        selectedPaymentMethod == _cardMastercard;
  }

  /// Checks if the selected payment method is a mobile wallet
  static bool isMobileWalletSelected(String selectedPaymentMethod) {
    return selectedPaymentMethod == _vodafoneCash ||
        selectedPaymentMethod == _etisalatCash ||
        selectedPaymentMethod == _orangeCash;
  }

  /// Checks if the selected payment method is cash
  static bool isCashPayment(String selectedPaymentMethod) {
    return selectedPaymentMethod == _cash;
  }
}
