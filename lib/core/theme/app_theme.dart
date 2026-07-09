import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2E7D32); // vert ferme
  static const primaryLight = Color(0xFFE8F5E9);
  static const primaryDark = Color(0xFF1B5E20);

  static const accent = Color(0xFFFF8F00);

  static const background = Color(0xFFF7F9F8);

  static const textPrimary = Color(0xFF1C1C1C);
  static const textSecondary = Color(0xFF6E6E6E);

  static const divider = Color(0xFFE0E0E0);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: AppColors.textPrimary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
    ),
  );
}