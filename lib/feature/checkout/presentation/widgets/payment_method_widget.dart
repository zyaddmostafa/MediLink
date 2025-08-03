import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentMethodWidget extends StatelessWidget {
  final String paymentType;
  final String title;
  final String iconAsset;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodWidget({
    super.key,
    required this.paymentType,
    required this.title,
    required this.iconAsset,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58.h,
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: isSelected
              ? AppColor.primary.withOpacity(0.1)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? AppColor.primary : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Selection Circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColor.primary : Colors.grey.shade400,
                  width: 2,
                ),
                color: isSelected ? AppColor.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 12, color: Colors.white)
                  : null,
            ),

            const SizedBox(width: 16),

            // Payment Method Title
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.font16Medium.copyWith(
                  color: isSelected ? AppColor.primary : Colors.black87,
                ),
              ),
            ),

            // Payment Method Icon
            SvgPicture.asset(iconAsset, width: 68),
          ],
        ),
      ),
    );
  }
}
