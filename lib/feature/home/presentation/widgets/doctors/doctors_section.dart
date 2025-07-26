import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../../data/model/doctor_model.dart';
import 'doctors_list_view.dart';
import '../home_body_header.dart';

class DoctorsSection extends StatelessWidget {
  final List<DoctorModel>? doctors;
  final bool isLoading;
  const DoctorsSection({super.key, this.doctors, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: HomeBodyHeader(
            title: 'Find Doctors',
            onSeeAllTap: () =>
                context.pushNamed(Routes.seeAllDoctors, arguments: doctors),
          ),
        ),
        verticalSpacing(24),
        Expanded(
          child: isLoading
              ? Skeletonizer(
                  enabled: true,
                  child: DoctorListView(
                    isFavorite: false,
                    doctors:
                        generateSkeletonDoctors(), // Provide dummy data for skeleton
                    shrinkWrap: true,
                  ),
                )
              : DoctorListView(
                  isFavorite: false,
                  doctors: doctors!.take(5).toList(),
                  shrinkWrap: true,
                ),
        ),
      ],
    );
  }
}
