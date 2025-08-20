import 'dart:developer';

import 'package:dio/dio.dart';

import 'paymob_constants.dart';

class PaymobManager {
  final dio = Dio()..options.headers = {'Content-Type': 'application/json'};

  Future<String> payWithPaymob({required int amount}) async {
    final token = await getToken();
    final orderId = await getOrderId(
      token: token,
      amount: (amount).toString(), // Convert amount to cents
    ); // Get the order ID
    final paymentKey = await getPaymentKey(
      token: token,
      orderId: orderId,
      amount: (amount).toString(),
    ); // Get the payment key

    return paymentKey; // Return the payment key for further processing
  }

  // Pay with mobile wallet (Vodafone, Etisalat, Orange)
  Future<String> payWithMobileWalletToken({required int amount}) async {
    final token = await getToken();
    final orderId = await getOrderId(
      token: token,
      amount: (amount).toString(), // Convert amount to cents
    );
    final paymentKey = await getPaymentKey(
      token: token,
      orderId: orderId,
      amount: (amount).toString(),
    );

    return paymentKey; // Return the payment key for mobile wallet
  }

  // get the user token
  Future<String> getToken() async {
    try {
      final response = await dio.post(
        '${Constants.baseUrl}${Constants.authToken}',
        data: {"api_key": Constants.paymobApiKey},
      );
      final token = response.data['token'];
      log('TOKEN: $token');
      return token;
    } catch (e) {
      if (e is DioException) {
        log('Token Error: ${e.response?.statusCode}');
        log('Token Error Data: ${e.response?.data}');
      }
      log('Token Error: $e');
      rethrow;
    }
  }

  // get the order id
  Future<int> getOrderId({
    required String token,
    required String amount,
  }) async {
    try {
      final requestData = {
        "auth_token": token,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": "EGP",
        "items": [],
      };
      log('Order Request Data: $requestData');

      final response = await dio.post(
        '${Constants.baseUrl}${Constants.orderId}',
        data: requestData,
      );
      log('ORDER ID: ${response.data['id']}');
      return response.data['id'];
    } catch (e) {
      if (e is DioException) {
        log('Order Error: ${e.response?.statusCode}');
        log('Order Error Data: ${e.response?.data}');
      }
      log('Order Error: $e');
      rethrow;
    }
  }

  // get the payment key
  Future<String> getPaymentKey({
    required String token,
    required int orderId,
    required String amount,
    bool isCardPayment = false,
  }) async {
    try {
      final requestData = {
        "auth_token": token,
        "amount_cents": amount,
        "expiration": 3600, // Add expiration for mobile wallet compatibility
        "order_id": orderId,
        "billing_data": {
          "apartment": "N/A",
          "email": "claudette09@exa.com",
          "floor": "N/A",
          "first_name": "Clifford",
          "street": "N/A",
          "building": "N/A",
          "phone_number": "+86(8)9135210487",
          "shipping_method": "N/A",
          "postal_code": "N/A",
          "city": "N/A",
          "country": "N/A",
          "last_name": "Nicolas",
          "state": "N/A",
        },
        "currency": "EGP",
        "integration_id": isCardPayment
            ? Constants.cardintegrationId
            : Constants.walletintegrationId,
        "lock_order_when_paid":
            "false", // Add this for mobile wallet compatibility
      };
      log('Payment Key Request Data: $requestData');

      final response = await dio.post(
        '${Constants.baseUrl}${Constants.paymentKey}',
        data: requestData,
      );
      log('PAYMENT KEY: ${response.data['token']}');
      return response.data['token'];
    } catch (e) {
      if (e is DioException) {
        log('Payment Key Error: ${e.response?.statusCode}');
        log('Payment Key Error Data: ${e.response?.data}');
      }
      log('Payment Key Error: $e');
      rethrow;
    }
  }

  // Pay with mobile wallet and get redirect URL
  Future<String> payWithMobileWallet({
    required String paymentToken,
    required String walletMobileNumber,
  }) async {
    try {
      final walletData = {
        "source": {"identifier": walletMobileNumber, "subtype": "WALLET"},
        "payment_token": paymentToken,
      };
      log('Mobile Wallet Payment Data: $walletData');

      final response = await dio.post(
        '${Constants.baseUrl}${Constants.walletPayment}',
        data: walletData,
      );

      if (response.data.containsKey('redirect_url')) {
        final redirectUrl = response.data['redirect_url'].toString();
        log('Mobile Wallet Redirect URL: $redirectUrl');
        return redirectUrl;
      } else {
        throw Exception('No redirect URL received from mobile wallet payment');
      }
    } catch (e) {
      if (e is DioException) {
        log('Mobile Wallet Payment Error: ${e.response?.statusCode}');
        log('Mobile Wallet Payment Error Data: ${e.response?.data}');
      }
      log('Mobile Wallet Payment Error: $e');
      rethrow;
    }
  }

  // Complete mobile wallet payment flow
  Future<String> mobileWalletPayment({
    required int amount,
    required String walletMobileNumber,
  }) async {
    try {
      // Step 1: Get auth token
      final token = await getToken();

      // Step 2: Create order
      final orderId = await getOrderId(
        token: token,
        amount: (amount).toString(), // Convert to cents
      );

      // Step 3: Get payment key for wallet (not card)
      final paymentToken = await getPaymentKey(
        token: token,
        orderId: orderId,
        amount: (amount).toString(),
        isCardPayment: false, // Use wallet integration ID
      );

      // Step 4: Make wallet payment request to get redirect URL
      final redirectUrl = await payWithMobileWallet(
        paymentToken: paymentToken,
        walletMobileNumber: walletMobileNumber,
      );

      return redirectUrl;
    } catch (e) {
      log('Complete Mobile Wallet Payment Error: $e');
      rethrow;
    }
  }
}
