import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import 'doctor_info_details.dart';

class DoctorProfessionalDetails extends StatelessWidget {
  final String? degree;
  final int? appointPrice;
  final String? phone;

  const DoctorProfessionalDetails({
    super.key,
    this.degree,
    this.appointPrice,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DoctorInfoDetails(value: degree ?? 'PhDs', label: 'Degree'),
          horizontalSpacing(24),
          DoctorInfoDetails(
            value: '\$${appointPrice?.toString() ?? '200'}',
            label: 'Price',
          ),
          horizontalSpacing(24),
          DoctorInfoDetails(
            value: phone ?? '+1-801-346-6622',
            label: 'Phone Number',
          ),
        ],
      ),
    );
  }
}
