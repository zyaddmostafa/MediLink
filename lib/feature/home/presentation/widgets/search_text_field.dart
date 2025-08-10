import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

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
            Assets.svgsSearch,
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
                    Assets.svgsClose,
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
