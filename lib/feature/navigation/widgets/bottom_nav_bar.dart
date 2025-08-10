import 'package:flutter/material.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/theme/app_color.dart';
import 'nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColor.primary),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              index: 0,
              iconPath: Assets.svgsHome,
              label: 'Home',
              currentIndex: currentIndex,
              onTabTapped: onTabTapped,
            ),
            NavItem(
              index: 1,
              iconPath: Assets.svgsBookings,
              label: 'Bookings',
              currentIndex: currentIndex,
              onTabTapped: onTabTapped,
            ),

            NavItem(
              index: 3,
              iconPath: Assets.svgsProfile,
              label: 'Profile',
              currentIndex: currentIndex,
              onTabTapped: onTabTapped,
            ),
          ],
        ),
      ),
    );
  }
}
