import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/api_helpers/api_error_handler.dart';
import '../../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routes.dart';
import '../../cubit/home_cubit.dart';
import 'doctors_list_view.dart';
import '../home_body_header.dart';

class DoctorsSection extends StatelessWidget {
  const DoctorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorsState = context.watch<HomeCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Fixed Header section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: HomeBodyHeader(
            title: 'Find Doctors',
            onSeeAllTap: () => context.pushNamed(
              Routes.seeAllDoctors,
              arguments: doctorsState is AllDoctorsSuccess
                  ? doctorsState.doctors
                  : [],
            ),
          ),
        ),

        verticalSpacing(24),

        // Scrollable Doctors list
        Expanded(child: _getAllDoctorsBlocBuilder()),
      ],
    );
  }

  Widget _getAllDoctorsBlocBuilder() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is AllDoctorsSuccess ||
          current is AllDoctorsLoading ||
          current is AllDoctorsError,
      builder: (context, state) {
        if (state is AllDoctorsLoading || state is AllDoctorsSuccess) {
          return Skeletonizer(
            enabled: state is AllDoctorsLoading,
            child: DoctorListView(
              isFavorite: false,
              shrinkWrap: true, // Allow full scrolling
              doctors: state is AllDoctorsSuccess
                  ? state.doctors.take(5).toList()
                  : generateSkeletonDoctors(),
            ),
          );
        } else if (state is AllDoctorsError) {
          return Center(
            child: Text(
              extractErrorMessages(
                state.error.errors ??
                    {'message': state.error.message ?? 'Unknown error'},
              ).join(','),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
