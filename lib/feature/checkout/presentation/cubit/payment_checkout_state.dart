part of 'payment_checkout_cubit.dart';

@immutable
sealed class PaymentCheckoutState {}

final class PaymentCheckoutInitial extends PaymentCheckoutState {}

final class PaymentCheckoutLoading extends PaymentCheckoutState {}

final class PaymentCheckoutNavigateToGateway extends PaymentCheckoutState {
  final PaymentResponse response;
  final String? paymentToken;
  final String? redirectUrl;
  final String gatewayType; // 'card' or 'wallet'

  PaymentCheckoutNavigateToGateway({
    required this.response,
    this.paymentToken,
    this.redirectUrl,
    required this.gatewayType,
  });
}
