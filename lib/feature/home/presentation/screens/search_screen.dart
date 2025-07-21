import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/doctors_list_view.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showCloseIcon = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showCloseIcon = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
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
            const DoctorListView(isFavorite: false),
          ],
        ),
      ),
    );
  }
}
