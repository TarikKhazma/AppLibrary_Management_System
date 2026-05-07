import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_string.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle _base({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColors.textPrimary,
    String? fontFamily,
    double? height,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily ?? AppString.fontFamilyEn,
        fontFamilyFallback: const [AppString.fontFamilyAr],
        height: height,
        letterSpacing: letterSpacing,
      );

  // Display
  static TextStyle displayLarge = _base(fontSize: 32, fontWeight: FontWeight.w700);
  static TextStyle displayMedium = _base(fontSize: 28, fontWeight: FontWeight.w700);
  static TextStyle displaySmall = _base(fontSize: 24, fontWeight: FontWeight.w700);

  // Headline
  static TextStyle headlineLarge = _base(fontSize: 22, fontWeight: FontWeight.w700);
  static TextStyle headlineMedium = _base(fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle headlineSmall = _base(fontSize: 18, fontWeight: FontWeight.w600);

  // Title
  static TextStyle titleLarge = _base(fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle titleMedium = _base(fontSize: 14, fontWeight: FontWeight.w600);
  static TextStyle titleSmall = _base(fontSize: 12, fontWeight: FontWeight.w600);

  // Body
  static TextStyle bodyLarge = _base(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle bodyMedium = _base(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle bodySmall = _base(fontSize: 12, fontWeight: FontWeight.w400);

  // Label
  static TextStyle labelLarge = _base(fontSize: 14, fontWeight: FontWeight.w500);
  static TextStyle labelMedium = _base(fontSize: 12, fontWeight: FontWeight.w500);
  static TextStyle labelSmall = _base(fontSize: 10, fontWeight: FontWeight.w500);

  // AppBar title (white)
  static TextStyle appBarTitle = _base(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textLight,
    letterSpacing: 0.3,
  );

  // Button text
  static TextStyle buttonText = _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  // Hint text
  static TextStyle hintText = _base(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // Arabic styles using Rakkas font
  static TextStyle arBody = _base(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppString.fontFamilyAr,
  );

  static TextStyle arTitle = _base(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: AppString.fontFamilyAr,
  );

  static TextStyle arAppBarTitle = _base(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    fontFamily: AppString.fontFamilyAr,
  );
}
