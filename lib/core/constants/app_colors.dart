import 'package:flutter/material.dart';

abstract class AppColors {
  static const primary = Color(0xFF00C853);
  static const primaryDark = Color(0xFF00E676);

  static const scaffoldLight = Color(0xFFF5F7FA);
  static const scaffoldDark = Color(0xFF0D1117);

  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF161B22);

  static const surfaceLight = Colors.white;
  static const surfaceDark = Color(0xFF1C2128);

  static const textPrimaryLight = Color(0xFF1A1A2E);
  static const textPrimaryDark = Colors.white;

  static const textSecondaryLight = Color(0xFF6B7280);
  static const textSecondaryDark = Color(0xFF9CA3AF);

  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFF9800);
  static const error = Color(0xFFF44336);

  static Color getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return success;
    if (confidence >= 0.5) return warning;
    return error;
  }
}