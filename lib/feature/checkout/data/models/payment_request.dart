import 'package:json_annotation/json_annotation.dart';
part 'payment_request.g.dart';

/// Base payment request class
abstract class PaymentRequest {
  final String paymentMethod;
  final int amount;
  final String appointmentId;
  final Map<String, dynamic>? metadata;

  const PaymentRequest({
    required this.paymentMethod,
    required this.amount,
    required this.appointmentId,
    this.metadata,
  });

  Map<String, dynamic> toJson();
}

/// Card payment request
@JsonSerializable()
class CardPaymentRequest extends PaymentRequest {
  final String cardType; // visa, mastercard

  const CardPaymentRequest({
    required super.paymentMethod,
    required super.amount,
    required super.appointmentId,
    required this.cardType,
    super.metadata,
  });

  factory CardPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CardPaymentRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CardPaymentRequestToJson(this);
}

/// Mobile wallet payment request
@JsonSerializable()
class MobileWalletPaymentRequest extends PaymentRequest {
  final String walletType; // vodafone, etisalat, orange
  final String mobileNumber;

  const MobileWalletPaymentRequest({
    required super.paymentMethod,
    required super.amount,
    required super.appointmentId,
    required this.walletType,
    required this.mobileNumber,
    super.metadata,
  });

  factory MobileWalletPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$MobileWalletPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MobileWalletPaymentRequestToJson(this);
}

/// Cash payment request
@JsonSerializable()
class CashPaymentRequest extends PaymentRequest {
  final DateTime confirmedAt;
  final String? notes;

  const CashPaymentRequest({
    required super.paymentMethod,
    required super.amount,
    required super.appointmentId,
    required this.confirmedAt,
    this.notes,
    super.metadata,
  });

  factory CashPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CashPaymentRequestFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CashPaymentRequestToJson(this);
}
