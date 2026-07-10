import 'package:flutter/material.dart';

class AppTheme {

  // Palette
  static const Color primary = Color(0xFF2E7D32);
  static const Color primaryDark = Color(0xFF1B2E1F);
  static const Color background = Color(0xFFF1F4F1);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB3261E);
  static const Color textPrimary = Color(0xFF1B2E1F);
  static const Color textSecondary = Color(0xFF5A6B5D);


  static ThemeData light = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor: background,

    primaryColor: primary,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      surface: surface,
      error: error,
    ),


    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),


    // Boutons principaux
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: primary.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),


    // Boutons texte (ex: "Créer un compte")
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ),


    // Boutons contour
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),


    // Champs de formulaire
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,

      contentPadding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: error),
      ),

      labelStyle: const TextStyle(color: textSecondary),

      prefixIconColor: primary,
    ),


    // Cartes (produit_card, commande_card, etc.)
    cardTheme: CardThemeData(
      color: surface,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),


    // Textes
    textTheme: const TextTheme(
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
    ),


    // Icônes par défaut
    iconTheme: const IconThemeData(
      color: primary,
    ),


    // Navigation basse (bottom nav bar, Espace Client)
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surface,
      selectedItemColor: primary,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),


    // Chips (catégories, filtres)
    chipTheme: ChipThemeData(
      backgroundColor: background,
      selectedColor: primary,
      labelStyle: const TextStyle(color: textPrimary),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),


    // Diviseurs
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
    ),

  );

}