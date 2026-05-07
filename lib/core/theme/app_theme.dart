import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_size.dart';
import '../constants/app_string.dart';
import '../constants/app_text_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get arabicTheme {
    final base = lightTheme;
    return base.copyWith(
      textTheme: base.textTheme.apply(fontFamily: AppString.fontFamilyAr),
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: AppTextStyle.arAppBarTitle,
      ),
    );
  }

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: AppString.fontFamilyEn,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyle.appBarTitle,
          iconTheme: const IconThemeData(color: AppColors.textLight),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          hintStyle: AppTextStyle.hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingMd,
            vertical: AppSize.paddingMd,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textLight,
            minimumSize: const Size(double.infinity, AppSize.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.radiusMd),
            ),
            textStyle: AppTextStyle.buttonText,
            elevation: 0,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 0.5,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 2,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.radiusMd),
          ),
        ),
      );
}
