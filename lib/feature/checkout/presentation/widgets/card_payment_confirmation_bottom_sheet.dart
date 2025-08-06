import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/doctors_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/model/appointment_details_model.dart';
import '../../data/model/store_appointment_request.dart';
import '../cubit/store_appointment_cubit.dart';

class CashPaymentBottomSheet extends StatelessWidget {
  final AppointmentDetailsModel appointmentDetails;
  final StoreAppointmentCubit? storeAppointmentCubit;

  const CashPaymentBottomSheet({
    super.key,
    required this.appointmentDetails,
    this.storeAppointmentCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.53,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          verticalSpacing(20),

          // Cash payment icon
          Container(
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.money, size: 30, color: AppColor.primary),
          ),
          verticalSpacing(20),

          // Title
          Text('Pay with Cash', style: AppTextStyles.font24Bold),
          verticalSpacing(8),

          // Subtitle
          Text(
            'You\'ll pay when you arrive at the clinic',
            style: AppTextStyles.font16Regular,
            textAlign: TextAlign.center,
          ),
          verticalSpacing(30),

          // Appointment details card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Doctor:', style: AppTextStyles.font16Regular),
                    Text(
                      appointmentDetails.doctorName,
                      style: AppTextStyles.font16SemiBold,
                    ),
                  ],
                ),
                verticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount:', style: AppTextStyles.font16Regular),
                    Text(
                      appointmentDetails.appointmentPrice.toString(),
                      style: AppTextStyles.font18Bold.copyWith(
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpacing(30),

          // Confirm Button
          CustomElevatedButton(
            properties: ButtonPropertiesModel(
              text: 'Confirm Appointment',
              textColor: Colors.white,
              backgroundColor: AppColor.primary,
              onPressed: () {
                final cubit =
                    storeAppointmentCubit ??
                    context.read<StoreAppointmentCubit>();
                cubit.storeAppointment(
                  StoreAppointmentRequest(
                    doctorId: appointmentDetails.doctorId.toString(),
                    appointmentDateAndTime:
                        DoctorsHelpers.storeAppointmentStartDate(
                          appointmentDetails.appointmentDate,
                          appointmentDetails.appointmentTime,
                        ),
                  ),
                );
              },
            ),
          ),
          verticalSpacing(12),

          // Cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: AppTextStyles.font18Bold),
          ),
        ],
      ),
    );
  }
}
