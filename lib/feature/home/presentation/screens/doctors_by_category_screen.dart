import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../data/model/category_model.dart';
import '../cubit/home_cubit.dart';
import '../widgets/doctors/doctors_list_view.dart';

class DoctorsByCategoriesScreen extends StatelessWidget {
  final CategoryModel categoryModel;
  const DoctorsByCategoriesScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomAppBar(
                appBarwidget: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    '${categoryModel.name} Doctors',
                    style: AppTextStyles.font18Bold,
                  ),
                ),
              ),
            ),
            verticalSpacing(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Results', style: AppTextStyles.font18Bold),
            ),
            verticalSpacing(24),
            // Here you would typically include a widget that lists all doctors
            _doctorsListViewBlocBuilder(context),
          ],
        ),
      ),
    );
  }
}

Widget _doctorsListViewBlocBuilder(BuildContext context) {
  return BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        current is DoctorsByCategorySuccess ||
        current is DoctorsByCategoryLoading ||
        current is DoctorsByCategoryError,
    builder: (context, state) {
      if (state is DoctorsByCategoryLoading ||
          state is DoctorsByCategorySuccess) {
        return Expanded(
          child: Skeletonizer(
            enabled: state is DoctorsByCategoryLoading,
            child: DoctorListView(
              doctors: state is DoctorsByCategorySuccess
                  ? state.doctors
                  : generateSkeletonDoctors(),
            ),
          ),
        );
      } else if (state is DoctorsByCategoryError) {
        return ErrorStateWidget(
          errorMessage: state.error.message,
          errorMessages: state.error.errors ?? {},
        );
      }
      return const SizedBox.shrink();
    },
  );
}
