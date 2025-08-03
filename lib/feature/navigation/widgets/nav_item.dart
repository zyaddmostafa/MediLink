import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_text_styles.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.iconPath,
    this.activeIconPath,
    required this.label,
    required this.currentIndex,
    required this.onTabTapped,
  });
  final int currentIndex; // This should be managed by the parent widget
  final Function(int) onTabTapped; // Callback to handle tab changes
  final int index;
  final String iconPath;
  final String? activeIconPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final iconToUse = isSelected && activeIconPath != null
        ? activeIconPath
        : iconPath;

    return GestureDetector(
      onTap: () => onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with proper size and color
            SvgPicture.asset(
              iconToUse!,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColor.white : AppColor.shadowTextColor,
                BlendMode.srcIn,
              ),
            ),
            verticalSpacing(8),
            // Label
            Text(
              label,
              style: AppTextStyles.font14Medium.copyWith(
                color: isSelected ? AppColor.white : AppColor.shadowTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
