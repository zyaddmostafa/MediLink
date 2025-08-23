/// Payment method model
class PaymentMethod {
  final String paymentType;
  final String title;
  final String iconAsset;

  const PaymentMethod({
    required this.paymentType,
    required this.title,
    required this.iconAsset,
  });
}

/// Helper class for payment methods
class PaymentMethodsHelper {
  /// List of available payment methods
  static const List<PaymentMethod> paymentMethods = [
    // Card payments
    PaymentMethod(
      paymentType: 'visa',
      title: 'Visa',
      iconAsset: 'assets/svgs/Visa.svg',
    ),
    PaymentMethod(
      paymentType: 'mastercard',
      title: 'Mastercard',
      iconAsset: 'assets/svgs/Mastercard.svg',
    ),

    // Mobile wallets
    PaymentMethod(
      paymentType: 'vodafone_cash',
      title: 'Vodafone Cash',
      iconAsset: 'assets/svgs/vodafone-icon.svg',
    ),
    PaymentMethod(
      paymentType: 'etisalat_cash',
      title: 'Etisalat Cash',
      iconAsset: 'assets/svgs/etisalat-and-logo.svg',
    ),
    PaymentMethod(
      paymentType: 'orange_cash',
      title: 'Orange Cash',
      iconAsset: 'assets/svgs/orange-3.svg',
    ),

    // Cash payment
    PaymentMethod(
      paymentType: 'Cash',
      title: 'Cash Payment',
      iconAsset: 'assets/svgs/cash-pay-svgrepo-com.svg',
    ),
  ];

  /// Check if the payment method is a card payment
  static bool isCardPayment(String paymentType) {
    return paymentType == 'visa' || paymentType == 'mastercard';
  }

  /// Check if the payment method is a mobile wallet
  static bool isMobileWallet(String paymentType) {
    return paymentType == 'vodafone_cash' ||
        paymentType == 'etisalat_cash' ||
        paymentType == 'orange_cash';
  }

  /// Check if the payment method is cash
  static bool isCashPayment(String paymentType) {
    return paymentType == 'Cash';
  }

  /// Get payment method by type
  static PaymentMethod? getPaymentMethodByType(String paymentType) {
    try {
      return paymentMethods.firstWhere(
        (method) => method.paymentType == paymentType,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all card payment methods
  static List<PaymentMethod> getCardPaymentMethods() {
    return paymentMethods
        .where((method) => isCardPayment(method.paymentType))
        .toList();
  }

  /// Get all mobile wallet payment methods
  static List<PaymentMethod> getMobileWalletMethods() {
    return paymentMethods
        .where((method) => isMobileWallet(method.paymentType))
        .toList();
  }

  /// Get formatted title for display
  static String getFormattedTitle(String paymentType) {
    final method = getPaymentMethodByType(paymentType);
    return method?.title ?? paymentType;
  }
}
