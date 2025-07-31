import 'package:flutter/material.dart';

class ButtonPropertiesModel {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool isLoading;

  ButtonPropertiesModel({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
    this.isLoading = false,
  });
}
