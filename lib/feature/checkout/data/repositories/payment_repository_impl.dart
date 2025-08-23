import 'dart:developer';

import '../apis/payment_api_service.dart';
import '../models/payment_request.dart';
import '../models/payment_response.dart';
import '../../../../core/helpers/app_assets.dart';

/// Concrete payment repository implementation
class PaymentRepository {
  final PaymentApiService _remoteDataSource;

  PaymentRepository(this._remoteDataSource);

  Future<PaymentResponse> processCardPayment(CardPaymentRequest request) async {
    try {
      log('PaymentRepository: Processing card payment for ${request.cardType}');
      return await _remoteDataSource.processCardPayment(request);
    } catch (e) {
      log('PaymentRepository: Card payment error - $e');
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

  Future<PaymentResponse> processMobileWalletPayment(
    MobileWalletPaymentRequest request,
  ) async {
    try {
      log('PaymentRepository: Processing ${request.walletType} wallet payment');
      return await _remoteDataSource.processMobileWalletPayment(request);
    } catch (e) {
      log('PaymentRepository: Mobile wallet payment error - $e');
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

  Future<PaymentResponse> processCashPayment(CashPaymentRequest request) async {
    try {
      log('PaymentRepository: Processing cash payment');
      return await _remoteDataSource.processCashPayment(request);
    } catch (e) {
      log('PaymentRepository: Cash payment error - $e');
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

  Future<PaymentResponse> validatePaymentResult(
    Map<String, dynamic> gatewayResult,
  ) async {
    try {
      log('PaymentRepository: Validating payment result');
      return await _remoteDataSource.validatePaymentResult(gatewayResult);
    } catch (e) {
      log('PaymentRepository: Payment validation error - $e');
      return PaymentResponse.failure(
        error: PaymentError(
          message: e.toString(),
          errorCode: 'VALIDATION_ERROR',
          type: PaymentErrorType.validationError,
        ),
      );
    }
  }

  List<PaymentMethod> getAvailablePaymentMethods() {
    return [
      const PaymentMethod(
        id: 'visa',
        name: 'Visa Card',
        type: 'card',
        iconAsset: Assets.svgsVisa,
      ),
      const PaymentMethod(
        id: 'mastercard',
        name: 'Mastercard',
        type: 'card',
        iconAsset: Assets.svgsMastercard,
      ),
      const PaymentMethod(
        id: 'cash',
        name: 'Cash',
        type: 'cash',
        iconAsset: Assets.svgsCashPaySvgrepoCom,
      ),
      const PaymentMethod(
        id: 'vodafone_cash',
        name: 'Vodafone Cash',
        type: 'wallet',
        iconAsset: Assets.svgsVodafoneIcon,
      ),
      const PaymentMethod(
        id: 'etisalat_cash',
        name: 'Etisalat Cash',
        type: 'wallet',
        iconAsset: Assets.svgsEtisalatAndLogo,
      ),
      const PaymentMethod(
        id: 'orange_cash',
        name: 'Orange Cash',
        type: 'wallet',
        iconAsset: Assets.svgsOrange3,
      ),
    ];
  }
}
