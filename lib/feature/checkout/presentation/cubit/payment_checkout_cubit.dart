import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer';

import '../../data/repositories/payment_repository_impl.dart';
import '../../data/models/payment_request.dart';
import '../../data/models/payment_response.dart';

part 'payment_checkout_state.dart';

/// Cubit for managing payment checkout process
class PaymentCheckoutCubit extends Cubit<PaymentCheckoutState> {
  final PaymentRepository _paymentRepository;

  PaymentCheckoutCubit(this._paymentRepository)
    : super(PaymentCheckoutInitial());

  /// Get available payment methods
  List<PaymentMethod> getAvailablePaymentMethods() {
    return _paymentRepository.getAvailablePaymentMethods();
  }

  /// Process card payment (Visa/Mastercard)
  void processCardPayment({
    required int amount,
    required String cardType,
    required String appointmentId,
  }) async {
    emit(PaymentCheckoutLoading());
    log('PaymentCheckoutCubit: Processing card payment for $cardType');

    try {
      final request = CardPaymentRequest(
        amount: amount,
        cardType: cardType,
        appointmentId: appointmentId,
        paymentMethod: cardType.toLowerCase(),
      );

      final response = await _paymentRepository.processCardPayment(request);

      if (response.isSuccess) {
        log(
          'PaymentCheckoutCubit: Card payment success, checking gateway data...',
        );
        log('PaymentCheckoutCubit: gatewayData = ${response.gatewayData}');

        // For card payments, we need to navigate to PayMob webview
        if (response.gatewayData != null &&
            response.gatewayData!.containsKey('paymentToken') &&
            response.gatewayData!['paymentToken'] != null) {
          final paymentToken = response.gatewayData!['paymentToken'] as String;
          log(
            'PaymentCheckoutCubit: Navigating to card gateway with token: $paymentToken',
          );

          emit(
            PaymentCheckoutNavigateToGateway(
              response: response,
              paymentToken: paymentToken,
              gatewayType: 'card',
            ),
          );
        }
      }
    } catch (e) {
      log('PaymentCheckoutCubit: Card payment error - $e');
      rethrow;
    }
  }

  /// Process mobile wallet payment (Vodafone, Etisalat, Orange)
  void processMobileWalletPayment({
    required int amount,
    required String walletType,
    required String mobileNumber,
    required String appointmentId,
  }) async {
    emit(PaymentCheckoutLoading());
    log('PaymentCheckoutCubit: Processing $walletType wallet payment');

    try {
      final request = MobileWalletPaymentRequest(
        amount: amount,
        walletType: walletType,
        mobileNumber: mobileNumber,
        appointmentId: appointmentId,
        paymentMethod: '${walletType.toLowerCase()}_cash',
      );

      final response = await _paymentRepository.processMobileWalletPayment(
        request,
      );

      if (response.isSuccess) {
        log(
          'PaymentCheckoutCubit: Mobile wallet payment success, checking gateway data...',
        );
        log('PaymentCheckoutCubit: gatewayData = ${response.gatewayData}');

        // For mobile wallet payments, we need to navigate to the webview with redirect URL
        if (response.gatewayData != null &&
            response.gatewayData!.containsKey('redirectUrl') &&
            response.gatewayData!['redirectUrl'] != null) {
          final redirectUrl = response.gatewayData!['redirectUrl'] as String;
          log(
            'PaymentCheckoutCubit: Navigating to wallet gateway with URL: $redirectUrl',
          );

          emit(
            PaymentCheckoutNavigateToGateway(
              response: response,
              redirectUrl: redirectUrl,
              gatewayType: 'wallet',
            ),
          );
        }
      }
    } catch (e) {
      log('PaymentCheckoutCubit: Mobile wallet payment error - $e');
      rethrow;
    }
  }

  /// Process cash payment confirmation
  void processCashPayment({
    required int amount,
    required String appointmentId,
    String? notes,
  }) async {
    emit(PaymentCheckoutLoading());
    log('PaymentCheckoutCubit: Processing cash payment');

    try {
      final request = CashPaymentRequest(
        amount: amount,
        appointmentId: appointmentId,
        paymentMethod: 'cash',
        confirmedAt: DateTime.now(),
        notes: notes,
      );

      await _paymentRepository.processCashPayment(request);
    } catch (e) {
      log('PaymentCheckoutCubit: Cash payment error - $e');
      rethrow;
    }
  }
}
