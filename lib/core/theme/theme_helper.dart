import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

abstract class ThemeHelper {
  static Color cardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.cardDark
        : AppColors.cardLight;
  }

  static Color surfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color textPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
  }

  static Color textSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
  }

  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}