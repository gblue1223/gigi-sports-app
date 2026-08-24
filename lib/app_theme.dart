import 'package:flutter/material.dart';

/// Design tokens translated from the GIGI web brand stylesheet.
class AppColors {
  static const primary = Color(0xFF2FA866);
  static const primaryDark = Color(0xFF1F7A4A);
  static const forestDark = Color(0xFF15140F);
  static const deepGreen = Color(0xFF0D2417);
  static const mint = Color(0xFF2FA866);
  static const mintLight = Color(0xFFF3F9F5);
  static const mintSoft = Color(0xFFE9F5EE);
  static const cream = Color(0xFFF7F4EC);
  static const creamDark = Color(0xFFF1EEE3);
  static const ink = Color(0xFF1C1D18);
  static const muted = Color(0xFF6B6B62);
  static const subtle = Color(0xFF9A9A8F);
  static const surface = cream;
  static const surfaceCard = Colors.white;
  static const line = Color(0xFFE7E4D8);
  static const green = primary;
  static const yellow = Color(0xFFC9A24B);
}

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.yellow,
    surface: AppColors.surfaceCard,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.surface,
    splashColor: AppColors.primary.withValues(alpha: 0.08),
    highlightColor: Colors.transparent,
    dividerColor: AppColors.line,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 34,
        height: 1.18,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        color: AppColors.forestDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        height: 1.24,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        color: AppColors.forestDark,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: AppColors.forestDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: AppColors.forestDark,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.55, color: AppColors.ink),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: AppColors.muted),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.forestDark,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.forestDark, size: 22),
      titleTextStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
        color: AppColors.forestDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceCard,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      hintStyle: const TextStyle(color: AppColors.subtle, fontSize: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(64, 52),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.forestDark,
        minimumSize: const Size(64, 52),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        side: const BorderSide(color: AppColors.line),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      indicatorColor: AppColors.mintSoft,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w800
              : FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryDark
              : AppColors.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          size: 24,
          color: states.contains(WidgetState.selected)
              ? AppColors.primaryDark
              : AppColors.muted,
        );
      }),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.forestDark,
      unselectedLabelColor: AppColors.muted,
      indicatorColor: AppColors.primary,
      dividerColor: AppColors.line,
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
      unselectedLabelStyle:
          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.forestDark,
      contentTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  );
}

class SectionTitle {
  static const style = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w800,
    color: AppColors.forestDark,
    letterSpacing: -0.5,
  );
}
