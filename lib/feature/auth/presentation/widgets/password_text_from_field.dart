import 'package:doctor_appoinment/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String hintText;

  const PasswordTextFormField({super.key, required this.hintText});

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscured,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.grey),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(16),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(16),
        ),

        filled: true,
        fillColor: AppColor.lightGrey,
        hintText: widget.hintText,

        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_off : Icons.visibility,
            color: AppColor.grey,
          ),
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
        ),
      ),
    );
  }
}
