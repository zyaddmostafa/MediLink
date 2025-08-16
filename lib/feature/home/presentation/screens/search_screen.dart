import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../data/model/doctor_model.dart';
import '../cubit/home_cubit.dart';
import '../widgets/doctors/doctors_list_view.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showCloseIcon = false;

  void _onSearchChanged(String query) {
    // Call the cubit method, debounce is handled there
    context.read<HomeCubit>().searchDoctors(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacing(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SearchTextField(
                searchController: _searchController,
                showCloseIcon: _showCloseIcon,
                onChanged: (query) {
                  setState(() {
                    _showCloseIcon = query.isNotEmpty;
                  });
                  _onSearchChanged(query);
                },
              ),
            ),

            verticalSpacing(16),

            // Doctors List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Results', style: AppTextStyles.font18Bold),
            ),
            verticalSpacing(16),
            _doctorsListViewBlocBuilder(context, _searchController),
          ],
        ),
      ),
    );
  }
}

@override
Widget _doctorsListViewBlocBuilder(
  BuildContext context,
  TextEditingController searchController,
) {
  return BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        current is SearchDoctorsSuccess ||
        current is SearchDoctorsLoading ||
        current is SearchDoctorsError ||
        current is SearchDoctorsClear,
    builder: (context, state) {
      switch (state) {
        case SearchDoctorsLoading():
          return _buildLoadingState();
        case SearchDoctorsSuccess():
          return _buildSuccessState(state.doctors);
        case SearchDoctorsError():
          return ErrorStateWidget(
            errorMessage: state.error.message,
            errorMessages: state.error.errors ?? {},
            onRetry: () =>
                context.read<HomeCubit>().searchDoctors(searchController.text),
          );
        case SearchDoctorsClear():
          return _buildDefaultState();
        default:
          return _buildDefaultState();
      }
    },
  );
}

/// Builds the loading state with skeleton doctors
Widget _buildLoadingState() {
  return Expanded(
    child: Skeletonizer(
      enabled: true,
      child: DoctorListView(doctors: generateSkeletonDoctors()),
    ),
  );
}

/// Builds the success state with actual doctors data
Widget _buildSuccessState(List<DoctorModel> doctors) {
  if (doctors.isEmpty) {
    return Expanded(
      child: ListView(
        children: [
          Center(child: Lottie.asset(Assets.lottieNoSearchResult)),
          Text(
            'No results found',
            style: AppTextStyles.font18Bold,
            textAlign: TextAlign.center,
          ),
          verticalSpacing(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Try searching with different keywords or check the spelling.',
              style: AppTextStyles.font14Regular,
              textAlign: TextAlign.center,
            ),
          ),
          verticalSpacing(24),
        ],
      ),
    );
  }
  return Expanded(child: DoctorListView(doctors: doctors));
}

/// Builds the default state when no search has been performed
Widget _buildDefaultState() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Lottie.asset(Assets.lottieNoSearchResult),
        Text('Search for the doctor you need', style: AppTextStyles.font18Bold),
      ],
    ),
  );
}
