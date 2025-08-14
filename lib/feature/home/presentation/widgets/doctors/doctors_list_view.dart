import 'package:flutter/material.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/model/button_properties_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../data/model/doctor_model.dart';
import 'doctors_card.dart';

class DoctorListView extends StatelessWidget {
  final List<DoctorModel> doctors;
  final bool shrinkWrap; // Control shrinkWrap behavior
  final ButtonPropertiesModel? buttonProperties; // Optional button properties

  const DoctorListView({
    super.key,
    required this.doctors,
    this.shrinkWrap = false,
    this.buttonProperties,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Performance optimizations
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      // Independence configurations
      addAutomaticKeepAlives: true, // Maintain widget state
      addRepaintBoundaries: true, // Independent repainting
      cacheExtent: 100, // Pre-cache for smooth scrolling
      // Layout
      shrinkWrap: shrinkWrap,
      itemCount: doctors.length,

      separatorBuilder: (context, index) => verticalSpacing(16),

      itemBuilder: (context, index) {
        return DoctorsCard(
          key: ValueKey(doctors[index].id), // Unique key for each card
          doctor: doctors[index],
          buttonProperties:
              buttonProperties ??
              ButtonPropertiesModel(
                text: 'Book Appointment',
                textColor: AppColor.primary,
                backgroundColor: AppColor.doctorCardButton,
                onPressed: () {
                  // Call the parent callback if provided
                  context.pushNamed(
                    Routes.doctorInfo,
                    arguments: doctors[index].id,
                  );
                },
              ),
        );
      },
    );
  }
}
