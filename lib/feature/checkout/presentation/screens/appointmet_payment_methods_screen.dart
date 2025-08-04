import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/paymob/paymob_manager.dart';
import '../../../../core/paymob/paymob_getway.dart';
import '../../../../core/paymob/paymob_mobile_getway.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../widgets/payment_method_widget.dart';

class AppointmentPaymentMethodsScreen extends StatefulWidget {
  const AppointmentPaymentMethodsScreen({super.key});

  @override
  State<AppointmentPaymentMethodsScreen> createState() =>
      _AppointmentPaymentMethodsScreenState();
}

class _AppointmentPaymentMethodsScreenState
    extends State<AppointmentPaymentMethodsScreen> {
  String selectedPaymentMethod = 'visa'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                // Visa Payment Method
                PaymentMethodWidget(
                  paymentType: 'visa',
                  title: 'Visa Card',
                  iconAsset: Assets.svgsVisa,
                  isSelected: selectedPaymentMethod == 'visa',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'visa';
                    });
                  },
                ),

                verticalSpacing(16),

                // Mastercard Payment Method
                PaymentMethodWidget(
                  paymentType: 'mastercard',
                  title: 'Mastercard',
                  iconAsset: Assets.svgsMastercard,
                  isSelected: selectedPaymentMethod == 'mastercard',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'mastercard';
                    });
                  },
                ),
                verticalSpacing(16),

                // Cash Payment Method
                PaymentMethodWidget(
                  paymentType: 'Cash',
                  title: 'Cash',
                  iconAsset: Assets.svgsCashPaySvgrepoCom,
                  isSelected: selectedPaymentMethod == 'Cash',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Cash';
                    });
                  },
                ),
                verticalSpacing(16),
                // Wallet Payment Method
                PaymentMethodWidget(
                  paymentType: 'Vodafone',
                  title: 'Vodafone Cash',
                  iconAsset: Assets.svgsVodafoneIcon,
                  isSelected: selectedPaymentMethod == 'Vodafone',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Vodafone';
                    });
                  },
                ),
                verticalSpacing(16),
                // Etisalat Payment Method
                PaymentMethodWidget(
                  paymentType: 'Etisalat',
                  title: 'Etisalat Cash',
                  iconAsset: Assets.svgsEtisalatAndLogo,
                  isSelected: selectedPaymentMethod == 'Etisalat',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Etisalat';
                    });
                  },
                ),
                verticalSpacing(16),
                // Orange Payment Method
                PaymentMethodWidget(
                  paymentType: 'Orange',
                  title: 'Orange Cash',
                  iconAsset: Assets.svgsOrange3,
                  isSelected: selectedPaymentMethod == 'Orange',
                  onTap: () {
                    setState(() {
                      selectedPaymentMethod = 'Orange';
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
    );
  }

  Future<void> _handlePaymentContinue(BuildContext context) async {
    log('Starting payment process for method: $selectedPaymentMethod');

    // Quick test for dialog functionality
    if (selectedPaymentMethod == 'Cash') {
      log('Processing cash payment...');
      // Handle cash payment
      await CustomDialog.showConfirmationDialog(
        context: context,
        title: 'Cash Payment',
        message:
            'Please pay 150 EGP on Reception to complete your appointment.',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
        onConfirm: () {
          context.pushAndRemoveUntil(Routes.mainNavigation);
        },
      );
    }

    final paymobManager = PaymobManager();

    if (_isCardPayment()) {
      log('Processing card payment...');
      bool loadingShown = false;
      try {
        // Show loading first (non-blocking)
        CustomDialog.showLoadingDialog(
          context: context,
          message: 'Processing payment...',
        );
        loadingShown = true;
        log('Loading dialog shown');

        // Handle card payments (Visa/Mastercard)
        log('Calling payWithPaymob...');
        final paymentKey = await paymobManager.payWithPaymob(amount: 150);
        log('Got payment key: $paymentKey');

        // Hide loading
        if (context.mounted && loadingShown) {
          Navigator.pop(context);
          loadingShown = false;
          log('Loading dialog dismissed');
        }

        if (context.mounted) {
          log('Navigating to PaymobGetway...');
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => PaymobGetway(paymentToken: paymentKey),
            ),
          );
          log('Payment result: $result');
          await _handlePaymentResult(result);
        }
      } catch (e) {
        log('Card payment error: $e');
        log('Error type: ${e.runtimeType}');

        // Hide loading if still showing
        if (context.mounted && loadingShown) {
          Navigator.pop(context);
          loadingShown = false;
          log('Loading dialog dismissed due to error');
        }

        // Show error dialog
        if (context.mounted) {
          await CustomDialog.showErrorDialog(
            context: context,
            title: 'Payment Failed',
            message: 'Unable to process card payment: ${e.toString()}',
            buttonText: 'Try Again',
          );
        }
        return; // Return early to prevent further execution
      }
    } else if (_isMobileWallet()) {
      log('Processing mobile wallet payment...');
      // Handle mobile wallet payments
      await _handleMobileWalletPayment(context, paymobManager);
    }
  }

  Future<void> _handleMobileWalletPayment(
    BuildContext context,
    PaymobManager paymobManager,
  ) async {
    log('Starting mobile wallet payment...');
    // Show dialog to get mobile number
    final mobileNumber = await _showMobileNumberDialog(context);
    log('Mobile number received: $mobileNumber');

    if (mobileNumber != null && mobileNumber.isNotEmpty) {
      bool loadingShown = false;
      try {
        log('Processing mobile wallet payment...');
        // Show loading (non-blocking)
        CustomDialog.showLoadingDialog(
          context: context,
          message: 'Processing ${_getWalletDisplayName()} payment...',
        );
        loadingShown = true;
        log('Mobile wallet loading dialog shown');

        log('Calling mobileWalletPayment...');
        final redirectUrl = await PaymobManager().mobileWalletPayment(
          amount: 150,
          walletMobileNumber: mobileNumber,
        );
        log('Got redirect URL: $redirectUrl');

        // Hide loading
        if (context.mounted && loadingShown) {
          Navigator.pop(context);
          loadingShown = false;
          log('Mobile wallet loading dialog dismissed');
        }

        // Navigate to mobile wallet WebView
        if (context.mounted) {
          log('Navigating to PaymobMobileGetway...');
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(
              builder: (context) => PaymobMobileGetway(
                webUri: redirectUrl,
                walletType: selectedPaymentMethod.toLowerCase(),
              ),
            ),
          );
          log('Mobile wallet result: $result');
          await _handlePaymentResult(result);
        }
      } catch (e) {
        log('Mobile wallet payment error: $e');
        log('Error type: ${e.runtimeType}');

        // Hide loading if still showing
        if (context.mounted && loadingShown) {
          Navigator.pop(context);
          loadingShown = false;
          log('Mobile wallet loading dialog dismissed due to error');
        }

        // Show error dialog
        if (context.mounted) {
          await CustomDialog.showErrorDialog(
            context: context,
            title: 'Mobile Wallet Payment Failed',
            message:
                'Unable to process ${_getWalletDisplayName()} payment: ${e.toString()}',
            buttonText: 'Try Again',
          );
        }
        return; // Return early
      }
    } else {
      log('Mobile number dialog cancelled or empty');
    }
  }

  bool _isCardPayment() {
    return selectedPaymentMethod == 'visa' ||
        selectedPaymentMethod == 'mastercard';
  }

  bool _isMobileWallet() {
    return selectedPaymentMethod == 'Vodafone' ||
        selectedPaymentMethod == 'Etisalat' ||
        selectedPaymentMethod == 'Orange';
  }

  Future<String?> _showMobileNumberDialog(BuildContext context) async {
    return await CustomDialog.showMobileNumberDialog(
      context: context,
      walletName: _getWalletDisplayName(),
      walletColor: _getWalletColor(),
    );
  }

  Future<void> _handlePaymentResult(Map<String, dynamic>? result) async {
    if (result != null) {
      final status = result['status'];
      final message = result['message'];

      if (status == 'success') {
        await CustomDialog.showConfirmationDialog(
          context: context,
          title: 'Payment Successful!',
          confirmText: 'Okay',
          message:
              message ??
              'Your payment has been completed successfully. Your appointment is confirmed.',
          onConfirm: () {
            context.pushAndRemoveUntil(Routes.mainNavigation);
          },
        );
      } else {
        await CustomDialog.showErrorDialog(
          context: context,
          title: 'Payment Failed',
          message:
              message ??
              'Payment could not be completed. Please try again or use a different payment method.',
          buttonText: 'Try Again',
        );
      }
    }
  }

  String _getWalletDisplayName() {
    switch (selectedPaymentMethod) {
      case 'Vodafone':
        return 'Vodafone Cash';
      case 'Etisalat':
        return 'Etisalat Cash';
      case 'Orange':
        return 'Orange Cash';
      default:
        return 'Mobile Wallet';
    }
  }

  Color _getWalletColor() {
    switch (selectedPaymentMethod) {
      case 'Vodafone':
        return const Color(0xFFE60000); // Vodafone red
      case 'Etisalat':
        return const Color(0xFF00B140); // Etisalat green
      case 'Orange':
        return const Color(0xFFFF6600); // Orange color
      default:
        return AppColor.primary;
    }
  }
}
