import '../theme/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLines;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColor.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primary),
          borderRadius: BorderRadius.circular(16),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(16),
        ),

        filled: true,
        fillColor: AppColor.lightGrey,
        hintText: hintText,
      ),
    );
  }
}
