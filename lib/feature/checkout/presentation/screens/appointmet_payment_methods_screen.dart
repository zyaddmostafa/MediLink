import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
