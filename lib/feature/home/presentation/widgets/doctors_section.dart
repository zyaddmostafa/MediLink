import 'package:flutter/material.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../data/model/doctors_response.dart';
import 'doctors_list_view.dart';
import 'home_body_header.dart';

class DoctorsSection extends StatelessWidget {
  final List<Doctor> doctors;
  const DoctorsSection({super.key, required this.doctors});

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
            onSeeAllTap: () => context.pushNamed(Routes.seeAllDoctors),
          ),
        ),
        verticalSpacing(24),
        Expanded(child: DoctorListView(isFavorite: false, doctors: doctors)),
      ],
    );
  }
}
