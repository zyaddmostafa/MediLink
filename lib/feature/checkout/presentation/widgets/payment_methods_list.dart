import 'package:flutter/material.dart';
import '../../data/helpers/payment_method_helper.dart';
import 'payment_method_list_item.dart';

class PaymentMethodsList extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;
  const PaymentMethodsList({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(PaymentMethodsHelper.paymentMethods.length, (
        index,
      ) {
        final method = PaymentMethodsHelper.paymentMethods[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PaymentMethodListItem(
            paymentType: method.paymentType,
            title: method.title,
            iconAsset: method.iconAsset,
            isSelected: selectedPaymentMethod == method.paymentType,
            onTap: () => onPaymentMethodSelected(method.paymentType),
          ),
        );
      }),
    );
  }
}
