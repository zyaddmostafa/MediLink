import 'dart:developer';

import '../../../../core/paymob/paymob_manager.dart';
import '../models/payment_request.dart';
import '../models/payment_response.dart';

abstract class PaymentApiService {
  Future<PaymentResponse> processCardPayment(CardPaymentRequest request);

  Future<PaymentResponse> processMobileWalletPayment(
    MobileWalletPaymentRequest request,
  );

  Future<PaymentResponse> processCashPayment(CashPaymentRequest request);

  Future<PaymentResponse> validatePaymentResult(
    Map<String, dynamic> gatewayResult,
  );
}

class PaymentApiServiceImpl implements PaymentApiService {
  final PaymobManager _paymobManager;

  PaymentApiServiceImpl(this._paymobManager);

  @override
  Future<PaymentResponse> processCardPayment(CardPaymentRequest request) async {
    try {
      log('PaymentApiService: Processing card payment for ${request.cardType}');

      final paymentKey = await _paymobManager.payWithPaymob(
        amount: request.amount,
      );

      // Ensure paymentKey is not null
      if (paymentKey.isEmpty) {
        throw Exception('Failed to get payment key from PayMob');
      }

      return PaymentResponse.success(
        transactionId: paymentKey,
        paymentMethod: request.paymentMethod,
        amount: request.amount,
        message: 'Card payment initiated successfully',
        gatewayData: {'paymentToken': paymentKey},
      );
    } catch (e) {
      log('PaymentApiService: Card payment error - $e');
      return PaymentResponse.failure(
        error: PaymentError(
          message: e.toString(),
          errorCode: 'CARD_PAYMENT_ERROR',
          type: PaymentErrorType.processingError,
        ),
        transactionId: 'failed_${DateTime.now().millisecondsSinceEpoch}',
        paymentMethod: request.paymentMethod,
        amount: request.amount,
      );
    }
  }

  @override
  Future<PaymentResponse> processMobileWalletPayment(
    MobileWalletPaymentRequest request,
  ) async {
    try {
      log('PaymentApiService: Processing ${request.walletType} wallet payment');

      final redirectUrl = await _paymobManager.mobileWalletPayment(
        amount: request.amount,
        walletMobileNumber: request.mobileNumber,
      );

      // Ensure redirectUrl is not null or empty
      if (redirectUrl.isEmpty) {
        throw Exception('Failed to get redirect URL from PayMob');
      }

      return PaymentResponse.success(
        transactionId: 'mobile_${DateTime.now().millisecondsSinceEpoch}',
        paymentMethod: request.paymentMethod,
        amount: request.amount,
        message: 'Mobile wallet payment initiated successfully',
        gatewayData: {'redirectUrl': redirectUrl},
      );
    } catch (e) {
      log('PaymentApiService: Mobile wallet payment error - $e');
      return PaymentResponse.failure(
        error: PaymentError(
          message: e.toString(),
          errorCode: 'WALLET_PAYMENT_ERROR',
          type: PaymentErrorType.processingError,
        ),
        transactionId: 'failed_${DateTime.now().millisecondsSinceEpoch}',
        paymentMethod: request.paymentMethod,
        amount: request.amount,
      );
    }
  }

  @override
  Future<PaymentResponse> processCashPayment(CashPaymentRequest request) async {
    try {
      log('PaymentApiService: Processing cash payment');

      // For cash payments, we just return success since no gateway is involved
      return PaymentResponse.success(
        transactionId: 'cash_${DateTime.now().millisecondsSinceEpoch}',
        paymentMethod: request.paymentMethod,
        amount: request.amount,
        message: 'Cash payment confirmed',
        gatewayData: {'confirmedAt': request.confirmedAt.toIso8601String()},
      );
    } catch (e) {
      log('PaymentApiService: Cash payment error - $e');
      return PaymentResponse.failure(
        error: PaymentError(
          message: e.toString(),
          errorCode: 'CASH_PAYMENT_ERROR',
          type: PaymentErrorType.processingError,
        ),
        transactionId: 'failed_${DateTime.now().millisecondsSinceEpoch}',
        paymentMethod: request.paymentMethod,
        amount: request.amount,
      );
    }
  }

  @override
  Future<PaymentResponse> validatePaymentResult(
    Map<String, dynamic> gatewayResult,
  ) async {
    try {
      log('PaymentApiService: Validating payment result');

      // Here you would implement actual validation logic based on your gateway
      // For now, we'll return a basic validation

      final success =
          gatewayResult['success'] == true ||
          gatewayResult['status'] == 'success';

      if (success) {
        return PaymentResponse.success(
          transactionId:
              gatewayResult['transaction_id']?.toString() ??
              'validated_${DateTime.now().millisecondsSinceEpoch}',
          paymentMethod:
              gatewayResult['payment_method']?.toString() ?? 'unknown',
          amount: (gatewayResult['amount'] as num?)?.toInt() ?? 0,
          message: 'Payment validation successful',
          gatewayData: gatewayResult,
        );
      } else {
        return PaymentResponse.failure(
          error: PaymentError(
            message:
                gatewayResult['error_message']?.toString() ??
                'Payment validation failed',
            errorCode: 'VALIDATION_FAILED',
            type: PaymentErrorType.validationError,
          ),
          transactionId: gatewayResult['transaction_id']?.toString(),
          paymentMethod: gatewayResult['payment_method']?.toString(),
          amount: (gatewayResult['amount'] as num?)?.toInt(),
        );
      }
    } catch (e) {
      log('PaymentApiService: Payment validation error - $e');
      return PaymentResponse.failure(
        error: PaymentError(
          message: e.toString(),
          errorCode: 'VALIDATION_ERROR',
          type: PaymentErrorType.validationError,
        ),
      );
    }
  }
}
