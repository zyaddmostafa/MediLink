import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../data/model/doctors_response.dart';
import 'doctors_list_view.dart';
import 'home_body_header.dart';

class DoctorsSection extends StatelessWidget {
  final List<Doctor>? doctors;
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
                        _generateSkeletonDoctors(), // Provide dummy data for skeleton
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

  // Generate dummy data for skeleton loading
  List<Doctor> _generateSkeletonDoctors() {
    return List.generate(
      5,
      (index) => Doctor(
        id: index,
        name: 'Dr. Loading Name',
        email: 'loading@email.com',
        phone: '123-456-7890',
        photo: '',
        gender: 'male',
        address: 'Loading Address',
        description: 'Loading description for skeleton',
        degree: 'MBBS',
        specialization: Specialization(id: 1, name: 'Loading'),
        city: City(id: 1, name: 'Loading City', governrate: null),
        appointPrice: 100,
        startTime: '09:00:00',
        endTime: '17:00:00',
      ),
    );
  }
}
