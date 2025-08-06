import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/model/appointment_details_model.dart';

class AppointmentDetailsActions extends StatelessWidget {
  final AppointmentDetailsModel appointmentDetails;
  final String? message;

  const AppointmentDetailsActions({
    super.key,
    required this.appointmentDetails,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      properties: ButtonPropertiesModel(
        text: 'Next',
        backgroundColor: AppColor.primary,
        textColor: AppColor.white,
        onPressed: () {
          _navigateToPaymentMethods(context);
        },
      ),
    );
  }

  void _navigateToPaymentMethods(BuildContext context) {
    final appointmentWithMessage = appointmentDetails.copyWith(
      message: message,
    );
    context.pushNamed(
      Routes.appointmentPaymentMethodsScreen,
      arguments: appointmentWithMessage,
    );
  }
}
