import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/doctors_list_view.dart';

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
          children: [
            verticalSpacing(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      Assets.assetsSvgsBack,
                      width: 24,
                      height: 24,
                    ),
                  ),
                  horizontalSpacing(16),
                  Expanded(
                    child: SearchTextField(
                      searchController: _searchController,
                      showCloseIcon: _showCloseIcon,
                    ),
                  ),
                ],
              ),
            ),

            verticalSpacing(16),

            // Doctors List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Results', style: AppTextStyles.font18Bold),
                  ),
                  verticalSpacing(16),
                  const Expanded(child: DoctorListView(isFavorite: false)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required TextEditingController searchController,
    required bool showCloseIcon,
  }) : _searchController = searchController,
       _showCloseIcon = showCloseIcon;

  final TextEditingController _searchController;
  final bool _showCloseIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search By Doctor Name',
        hintStyle: AppTextStyles.font16Medium.copyWith(color: AppColor.grey),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            Assets.assetsSvgsSearch,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(AppColor.grey, BlendMode.srcIn),
          ),
        ),
        suffixIcon: _showCloseIcon
            ? InkWell(
                onTap: () {
                  _searchController.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    Assets.assetsSvgsClose,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColor.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColor.veryLightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primary, width: 1),
        ),
      ),
    );
  }
}
