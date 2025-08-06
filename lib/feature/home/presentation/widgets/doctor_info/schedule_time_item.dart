import 'package:flutter/material.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ScheduleTimeItem extends StatelessWidget {
  final String timeSlot;
  final bool isSelected;
  final VoidCallback onTap;

  const ScheduleTimeItem({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: isSelected ? AppColor.primary.withOpacity(0.1) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected ? AppColor.primary : const Color(0xFFF0F4FB),
            ),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Center(
          child: Text(
            timeSlot,
            style: AppTextStyles.font14Medium.copyWith(
              color: isSelected ? AppColor.primary : AppColor.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
