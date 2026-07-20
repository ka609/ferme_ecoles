import 'package:flutter/material.dart';

class AppTheme {
  // =========================
  // Palette
  // =========================

  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF1B5E20);

  static const Color secondary = Color(0xFFFFB300);

  static const Color background = Color(0xFFF1F4F1);
  static const Color surface = Colors.white;

  static const Color error = Color(0xFFB3261E);

  static const Color textPrimary = Color(0xFF1B2E1F);
  static const Color textSecondary = Color(0xFF5A6B5D);

  // =========================
  // Espacements
  // =========================

  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXL = 20;

  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;

  // =========================
  // Theme principal
  // =========================

  static ThemeData light = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: error,
    ),

    // =========================
    // AppBar
    // =========================

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 3,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    // =========================
    // ElevatedButton
    // =========================

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey,
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // =========================
    // OutlinedButton
    // =========================

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary),
        minimumSize: const Size(double.infinity, 50),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
      ),
    ),

    // =========================
    // TextButton
    // =========================

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // =========================
    // Champs
    // =========================

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      labelStyle: const TextStyle(
        color: textSecondary,
      ),

      hintStyle: const TextStyle(
        color: Colors.grey,
      ),

      prefixIconColor: primary,

      suffixIconColor: primary,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(
          color: error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(
          color: error,
          width: 1.5,
        ),
      ),
    ),

    // =========================
    // Cartes
    // =========================

    cardTheme: CardThemeData(
      color: surface,
      elevation: 1,
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    ),

    // =========================
    // Textes
    // =========================

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 15,
        color: textPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
      ),

      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondary,
      ),
    ),

    // =========================
    // Icônes
    // =========================

    iconTheme: const IconThemeData(
      color: primary,
      size: 24,
    ),

    // =========================
    // BottomNavigationBar
    // =========================

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // =========================
    // NavigationBar (Material 3)
    // =========================

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: primary.withOpacity(.15),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? primary
              : textSecondary,
        ),
      ),
    ),

    // =========================
    // Floating Action Button
    // =========================

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    // =========================
    // SnackBar
    // =========================

    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryDark,
      contentTextStyle: const TextStyle(
        color: Colors.white,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
    ),

    // =========================
    // Dialog
    // =========================

    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    ),

    // =========================
    // ProgressIndicator
    // =========================

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary,
    ),

    // =========================
    // Checkbox
    // =========================

    checkboxTheme: const CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(primary),
    ),

    // =========================
    // Radio
    // =========================

    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(primary),
    ),

    // =========================
    // Switch
    // =========================

    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(primary),
    ),

    // =========================
    // ListTile
    // =========================

    listTileTheme: const ListTileThemeData(
      iconColor: primary,
      textColor: textPrimary,
    ),

    // =========================
    // PopupMenu
    // =========================

    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
    ),

    // =========================
    // SearchBar
    // =========================

    searchBarTheme: const SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(surface),
    ),

    // =========================
    // Chips
    // =========================

    chipTheme: ChipThemeData(
      backgroundColor: background,
      selectedColor: primary,
      labelStyle: const TextStyle(
        color: textPrimary,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusXL),
      ),
    ),

    // =========================
    // Scrollbar
    // =========================

    scrollbarTheme: const ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(primary),
    ),

    // =========================
    // Tooltip
    // =========================

    tooltipTheme: const TooltipThemeData(
      textStyle: TextStyle(
        color: Colors.white,
      ),
    ),

    // =========================
    // Divider
    // =========================

    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
    ),

    // =========================
    // Animations de navigation
    // =========================

    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        
      },
    ),
  );
}