import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/paymob/paymob_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../presentation/widgets/card_payment_confirmation_bottom_sheet.dart';
import 'appointment_details_model.dart';
import 'payment_utility.dart';

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

class PaymentMethodsHelper {
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

  static Future<void> handleCashPayment(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    log('Processing cash payment...');
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          CashPaymentBottomSheet(appointmentDetails: appointmentDetails),
    );
  }

  static Future<void> handleCardPayment(
    BuildContext context,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    log('Processing card payment...');

    return await PaymentUtility.executeWithLoading(
      context: context,
      loadingMessage: 'Processing payment...',
      action: () async {
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
      },
      errorTitle: 'Card Payment Failed',
      errorMessage: 'Unable to process card payment',
    );
  }

  static Future<void> handleMobileWalletPayment(
    BuildContext context,
    String selectedPaymentMethod,
    int appointmentPrice,
    AppointmentDetailsModel appointmentDetails,
  ) async {
    try {
      final mobileNumber = await _getMobileNumberFromUser(
        context,
        selectedPaymentMethod,
      );

      if (mobileNumber == null || mobileNumber.isEmpty) {
        return; // User cancelled or provided empty number
      }
      final paymobmanager = PaymobManager();
      await _processWalletPayment(
        context: context,
        paymobManager: paymobmanager,
        selectedPaymentMethod: selectedPaymentMethod,
        appointmentPrice: appointmentPrice,
        appointmentDetails: appointmentDetails,
        mobileNumber: mobileNumber,
      );
    } catch (e) {
      if (context.mounted) {
        await PaymentUtility.showPaymentError(
          context: context,
          title: 'Mobile Wallet Payment Failed',
          message:
              'Unable to process $selectedPaymentMethod payment: ${e.toString()}',
          buttonText: 'Try Again',
        );
      }
    }
  }

  static Future<String?> _getMobileNumberFromUser(
    BuildContext context,
    String selectedPaymentMethod,
  ) async {
    return await CustomDialog.showMobileNumberDialog(
      context: context,
      walletName: selectedPaymentMethod,
      walletColor: AppColor.primary,
    );
  }

  static Future<void> _processWalletPayment({
    required BuildContext context,
    required PaymobManager paymobManager,
    required String selectedPaymentMethod,
    required int appointmentPrice,
    required AppointmentDetailsModel appointmentDetails,
    required String mobileNumber,
  }) async {
    return await PaymentUtility.executeWithLoading(
      context: context,
      loadingMessage: 'Processing $selectedPaymentMethod payment...',
      action: () async {
        final redirectUrl = await paymobManager.mobileWalletPayment(
          amount: appointmentPrice,
          walletMobileNumber: mobileNumber,
        );

        if (context.mounted) {
          await context.pushNamed(
            Routes.paymobMobileGetway,
            arguments: {
              'webUri': redirectUrl,
              'walletType': selectedPaymentMethod.toLowerCase(),
              'appointmentDetails': appointmentDetails,
            },
          );
        }
      },
      errorTitle: 'Mobile Wallet Payment Failed',
      errorMessage: 'Unable to process $selectedPaymentMethod payment',
    );
  }

  static bool isCardPayment(String selectedPaymentMethod) {
    return selectedPaymentMethod == 'visa' ||
        selectedPaymentMethod == 'mastercard';
  }

  static bool isMobileWalletSelected(String selectedPaymentMethod) {
    return selectedPaymentMethod == 'Vodafone Cash' ||
        selectedPaymentMethod == 'Etisalat Cash' ||
        selectedPaymentMethod == 'Orange Cash';
  }
}
