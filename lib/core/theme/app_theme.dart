import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.cardLight,
      background: AppColors.scaffoldLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryLight,
      onBackground: AppColors.textPrimaryLight,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.cardLight,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondaryLight,
    ),
    dividerColor: Colors.grey.shade200,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardLight,
      hintStyle: TextStyle(color: AppColors.textSecondaryLight),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.scaffoldDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.primaryDark,
      surface: AppColors.cardDark,
      background: AppColors.scaffoldDark,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: AppColors.textPrimaryDark,
      onBackground: AppColors.textPrimaryDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.cardDark,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.cardDark,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.textSecondaryDark,
    ),
    dividerColor: Colors.grey.shade800,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardDark,
      hintStyle: TextStyle(color: AppColors.textSecondaryDark),
    ),
  );
}