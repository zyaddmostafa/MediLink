import 'package:flutter/material.dart';

class ButtonPropertiesModel {
  final String? text;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool? isLoading;
  final double? verticalPadding;

  ButtonPropertiesModel({
    this.text,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.isLoading = false,
    this.verticalPadding,
  });

  ButtonPropertiesModel copyWith({
    String? text,
    Color? textColor,
    Color? backgroundColor,
    Function(int)? onPressedWithArgument,
    int? argument,
    VoidCallback? onPressed,
    bool? isLoading,
    double? verticalPadding,
  }) {
    return ButtonPropertiesModel(
      text: text ?? this.text,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,

      onPressed: onPressed ?? this.onPressed,
      isLoading: isLoading ?? this.isLoading,
      verticalPadding: verticalPadding ?? this.verticalPadding,
    );
  }
}
