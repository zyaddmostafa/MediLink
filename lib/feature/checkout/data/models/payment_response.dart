import 'package:json_annotation/json_annotation.dart';
part 'payment_response.g.dart';

/// Payment response class
@JsonSerializable()
class PaymentResponse {
  final bool isSuccess;
  final String transactionId;
  final String paymentMethod;
  final int amount;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? gatewayData;
  final PaymentError? error;

  const PaymentResponse({
    required this.isSuccess,
    required this.transactionId,
    required this.paymentMethod,
    required this.amount,
    required this.message,
    required this.timestamp,
    this.gatewayData,
    this.error,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);

  /// Create a successful payment response
  factory PaymentResponse.success({
    required String transactionId,
    required String paymentMethod,
    required int amount,
    required String message,
    Map<String, dynamic>? gatewayData,
  }) {
    return PaymentResponse(
      isSuccess: true,
      transactionId: transactionId,
      paymentMethod: paymentMethod,
      amount: amount,
      message: message,
      timestamp: DateTime.now(),
      gatewayData: gatewayData,
    );
  }

  /// Create a failed payment response
  factory PaymentResponse.failure({
    required PaymentError error,
    String? transactionId,
    String? paymentMethod,
    int? amount,
    Map<String, dynamic>? gatewayData,
  }) {
    return PaymentResponse(
      isSuccess: false,
      transactionId: transactionId ?? '',
      paymentMethod: paymentMethod ?? '',
      amount: amount ?? 0,
      message: error.message,
      timestamp: DateTime.now(),
      gatewayData: gatewayData,
      error: error,
    );
  }

  /// Copy with new values
  PaymentResponse copyWith({
    bool? isSuccess,
    String? transactionId,
    String? paymentMethod,
    int? amount,
    String? message,
    DateTime? timestamp,
    Map<String, dynamic>? gatewayData,
    PaymentError? error,
  }) {
    return PaymentResponse(
      isSuccess: isSuccess ?? this.isSuccess,
      transactionId: transactionId ?? this.transactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      gatewayData: gatewayData ?? this.gatewayData,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'PaymentResponse(isSuccess: $isSuccess, transactionId: $transactionId, '
        'paymentMethod: $paymentMethod, amount: $amount, message: $message)';
  }
}

/// Payment error class
@JsonSerializable()
class PaymentError {
  final String message;
  final String errorCode;
  final PaymentErrorType type;
  final Map<String, dynamic>? details;

  const PaymentError({
    required this.message,
    required this.errorCode,
    required this.type,
    this.details,
  });

  factory PaymentError.fromJson(Map<String, dynamic> json) =>
      _$PaymentErrorFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentErrorToJson(this);

  @override
  String toString() {
    return 'PaymentError(type: $type, code: $errorCode, message: $message)';
  }
}

/// Payment error types
enum PaymentErrorType {
  networkError,
  paymentDeclined,
  insufficientFunds,
  processingError,
  validationError,
  userCancelled,
  timeout,
  serverError,
  unknown,
}

/// Simple payment method class
class PaymentMethod {
  final String id;
  final String name;
  final String type;
  final String iconAsset;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.iconAsset,
  });
}
