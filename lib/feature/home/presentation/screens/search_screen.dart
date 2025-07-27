import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
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
      if (state is SearchDoctorsSuccess || state is SearchDoctorsLoading) {
        return Expanded(
          child: Skeletonizer(
            enabled: state is SearchDoctorsLoading,
            child: DoctorListView(
              isFavorite: false,
              doctors: state is SearchDoctorsSuccess
                  ? state.doctors
                  : generateSkeletonDoctors(),
            ),
          ),
        );
      } else if (state is SearchDoctorsError) {
        return Center(
          child: Text(
            extractErrorMessages(
              state.error.errors ??
                  {'message': state.error.message ?? 'Unknown error'},
            ).join(', '),
          ),
        );
      } else {
        return const Center(child: Text('No results found'));
      }
    },
  );
}
