import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF1A1A1A); // Deep Black
  static const Color secondary = Color(0xFFD4AF37); // Gold Accent
  static const Color accent = Color(0xFFE0E0E0); // Light Gray

  // Background
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFF9F9F9);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Aliases for common usage (assume Light mode default for static access, but Theme should be used ideally)
  static const Color background = backgroundLight;
  static const Color surface = surfaceLight;

  // Text
  static const Color textLightPrimary = Color(0xFF000000);
  static const Color textLightSecondary = Color(0xFF666666);
  static const Color textDarkPrimary = Color(0xFFFFFFFF);
  static const Color textDarkSecondary = Color(0xFFAAAAAA);

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);

  // Transparent
  static const Color transparent = Colors.transparent;
}
