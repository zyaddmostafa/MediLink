import 'app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Regular (400)
  static TextStyle font16Regular = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColor.grey,
  );

  static TextStyle font14Regular = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.doctorCardSubtitle,
  );

  // Medium (500)
  static TextStyle font18Medium = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.primary
        : AppColor.grey,
  );

  static TextStyle font16Medium = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : AppColor.white,
  );

  static TextStyle font14Medium = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : AppColor.cardsTitleColor,
  );

  static TextStyle font12Medium = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  );

  // SemiBold (600)
  static TextStyle font16SemiBold = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  static TextStyle font14SemiBold = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : AppColor.cardsTitleColor,
  );

  static TextStyle font12SemiBold = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.grey
        : AppColor.doctorCardSubtitle,
  );

  // Bold (700)
  static TextStyle font24Bold = GoogleFonts.openSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : AppColor.cardsTitleColor,
  );

  static TextStyle font18Bold = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : Colors.white,
  );

  static TextStyle font16Bold = GoogleFonts.openSans(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ThemeData().brightness == Brightness.light
        ? AppColor.black
        : AppColor.cardsTitleColor,
  );
}
