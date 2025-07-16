import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_text_styles.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      cardColor: AppColor.white,

      // Color Scheme
      //   colorScheme: ColorScheme.light(
      //     primary: AppColor.primaryColor,
      //     onPrimaryContainer: AppColor.white,
      //     secondary: AppColor.babyBlue,
      //     surface: AppColor.white,
      //     background: const Color(0xFFF8F9FA), // Light shade of white
      //     error: AppColor.red,
      //     onPrimary: AppColor.white,
      //     onSecondary: AppColor.black,
      //     onSurface: AppColor.black,
      //     onBackground: AppColor.black,
      //     onError: AppColor.white,
      //   ),

      // Scaffold Background
      scaffoldBackgroundColor: const Color(0xFFF8F9FA),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.font24Bold.copyWith(color: AppColor.black),
        headlineMedium: AppTextStyles.font18Bold.copyWith(
          color: AppColor.black,
        ),
        bodyLarge: AppTextStyles.font16Regular.copyWith(color: AppColor.black),
        bodyMedium: AppTextStyles.font14Regular.copyWith(color: AppColor.black),
        labelLarge: AppTextStyles.font16SemiBold.copyWith(
          color: AppColor.black,
        ),
        labelMedium: AppTextStyles.font14SemiBold.copyWith(
          color: AppColor.black,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColor.black, size: 24),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.white,
          textStyle: AppTextStyles.font16SemiBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.red),
        ),
        hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColor.grey),
        labelStyle: AppTextStyles.font14Medium.copyWith(color: AppColor.grey),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      cardColor: AppColor.black,
      // Color Scheme
      //   colorScheme: ColorScheme.dark(
      //     primary: AppColor.primaryColor,
      //     secondary: AppColor.babyBlue,
      //     surface: const Color(0xFF1E1E1E), // Dark shade of black
      //     background: const Color(0xFF121212), // Darker shade of black
      //     error: AppColor.red,
      //     onPrimary: AppColor.white,
      //     onSecondary: AppColor.white,
      //     onSurface: AppColor.white,
      //     onBackground: AppColor.white,
      //     onError: AppColor.white,
      //   ),

      // Scaffold Background
      scaffoldBackgroundColor: const Color(0xFF121212),

      // Card Theme

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.font24Bold.copyWith(color: AppColor.white),
        headlineMedium: AppTextStyles.font18Bold.copyWith(
          color: AppColor.white,
        ),
        bodyLarge: AppTextStyles.font16Regular.copyWith(color: AppColor.white),
        bodyMedium: AppTextStyles.font14Regular.copyWith(color: AppColor.white),
        labelLarge: AppTextStyles.font16SemiBold.copyWith(
          color: AppColor.white,
        ),
        labelMedium: AppTextStyles.font14SemiBold.copyWith(
          color: AppColor.white,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColor.white, size: 24),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.white,
          textStyle: AppTextStyles.font16SemiBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A), // Darker shade for input fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.red),
        ),
        hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColor.grey),
        labelStyle: AppTextStyles.font14Medium.copyWith(color: AppColor.grey),
      ),
    );
  }
}
