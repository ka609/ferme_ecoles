import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette inspirée du template Ogani (thème "bio / agroécologie").
/// Vert dominant pour rappeler la nature, orange en accent pour les CTA
/// (bouton "Ajouter au panier", badges promo, etc.)
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6FAA2C); // vert feuille (boutons, header)
  static const Color primaryDark = Color(0xFF4E7A1F); // vert foncé (hover / titres)
  static const Color primaryLight = Color(0xFFEAF4DD); // vert très clair (fonds de section)

  static const Color accent = Color(0xFFF7941D); // orange (prix, promos, badges)
  static const Color accentLight = Color(0xFFFFF1DF);

  static const Color textPrimary = Color(0xFF2E2E2E);
  static const Color textSecondary = Color(0xFF7A7A7A);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF7F8F5);
  static const Color divider = Color(0xFFE7E7E7);

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);

  // Statuts de commande (Espace Client / Producteur)
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusValidated = Color(0xFF2196F3);
  static const Color statusShipped = Color(0xFF9C27B0);
  static const Color statusDelivered = Color(0xFF4CAF50);
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme);

    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: textTheme.copyWith(
        headlineSmall: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.divider),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1),
    );
  }
}