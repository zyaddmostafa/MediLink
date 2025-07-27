import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_error_model.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
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
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showCloseIcon = _searchController.text.isNotEmpty;
      });
      // Debounce the search
      _onSearchChanged(_searchController.text);
    });
  }

  void _onSearchChanged(String query) {
    // Cancel the previous timer
    _debounceTimer?.cancel();

    // Create a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      triggerSearchDoctors(query);
    });
  }

  void triggerSearchDoctors(String doctorName) {
    if (doctorName.isNotEmpty) {
      context.read<HomeCubit>().searchDoctors(doctorName);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel(); // Cancel timer on dispose
    _searchController.dispose();
    super.dispose();
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
              child: CustomAppBar(
                appBarwidget: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: SearchTextField(
                      searchController: _searchController,
                      showCloseIcon: _showCloseIcon,
                    ),
                  ),
                ),
              ),
            ),

            verticalSpacing(16),

            // Doctors List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text('Results', style: AppTextStyles.font18Bold),
            ),
            verticalSpacing(16),
            _doctorsListViewBlocBuilder(context),
          ],
        ),
      ),
    );
  }
}

@override
Widget _doctorsListViewBlocBuilder(BuildContext context) {
  return BlocBuilder<HomeCubit, HomeState>(
    buildWhen: (previous, current) =>
        current is SearchDoctorsSuccess ||
        current is SearchDoctorsLoading ||
        current is SearchDoctorsError,
    builder: (context, state) {
      switch (state) {
        case SearchDoctorsLoading():
          return _buildLoadingState();
        case SearchDoctorsSuccess():
          return _buildSuccessState(state.doctors);
        case SearchDoctorsError():
          return _buildErrorState(state.error);
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
      child: DoctorListView(
        isFavorite: false,
        doctors: generateSkeletonDoctors(),
      ),
    ),
  );
}

/// Builds the success state with actual doctors data
Widget _buildSuccessState(List<DoctorModel> doctors) {
  if (doctors.isEmpty) {
    return Expanded(
      child: ListView(
        children: [
          Center(child: Lottie.asset(Assets.assetsLottieNoSearchResult)),
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
  return Expanded(child: DoctorListView(isFavorite: false, doctors: doctors));
}

/// Builds the error state with error message
Widget _buildErrorState(ApiErrorModel error) {
  return Center(
    child: Text(
      extractErrorMessages(
        error.errors ?? {'message': error.message ?? 'Unknown error'},
      ).join(', '),
    ),
  );
}

/// Builds the default state when no search has been performed
Widget _buildDefaultState() {
  return Center(child: Lottie.asset(Assets.assetsLottieNoSearchResult));
}
