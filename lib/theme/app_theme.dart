import 'package:flutter/material.dart';

/// Central color palette + theme for the app, matching the dark
/// Movie Details / Search UI.
class AppColors {
  static const background = Color(0xFF121212);
  static const card = Color(0xFF1E1E1E);
  static const accentRed = Color(0xFFE53935);
  static const accentOrange = Color(0xFFF5A623);
  static const chipBackground = Color(0xFF2A2A2A);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9E9E9E);
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      // fontFamily: 'Roboto', // uncomment once assets/fonts/Roboto.ttf is added + declared in pubspec.yaml
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accentOrange,
        brightness: Brightness.dark,
        surface: AppColors.background,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentRed,
          foregroundColor: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textPrimary),
      ),
      useMaterial3: true,
    );
  }
}
