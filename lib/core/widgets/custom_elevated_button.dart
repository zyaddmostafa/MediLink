import '../model/button_properties_model.dart';
import '../theme/app_color.dart';
import '../theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final ButtonPropertiesModel properties;
  const CustomElevatedButton({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: properties.backgroundColor ?? AppColor.primary,
      ),
      onPressed: properties.isLoading == true
          ? null
          : () {
              // If onPressedWithArgument is provided, use it with the argument
              if (properties.onPressedWithArgument != null) {
                properties.onPressedWithArgument!(properties.argument ?? 0);
              }
              // Also call the regular onPressed if provided
              else if (properties.onPressed != null) {
                properties.onPressed!();
              }
            },
      child: properties.isLoading == true
          ? const CircularProgressIndicator(color: AppColor.white)
          : Text(
              properties.text!,
              style: AppTextStyles.font16Bold.copyWith(
                color: properties.textColor ?? AppColor.white,
              ),
            ),
    );
  }
}
