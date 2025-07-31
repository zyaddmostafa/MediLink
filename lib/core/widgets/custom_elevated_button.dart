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
        backgroundColor: properties.backgroundColor,
      ),
      onPressed: properties.onPressed,
      child: properties.isLoading
          ? const CircularProgressIndicator(color: AppColor.white)
          : Text(
              properties.text,
              style: AppTextStyles.font16Bold.copyWith(
                color: properties.textColor,
              ),
            ),
    );
  }
}
