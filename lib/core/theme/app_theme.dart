import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
      displayMedium: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
      displaySmall: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
      headlineMedium: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
      titleLarge: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
      bodyLarge: GoogleFonts.lato(fontSize: 16, color: AppColors.textLightPrimary),
      bodyMedium: GoogleFonts.lato(fontSize: 14, color: AppColors.textLightSecondary),
      labelLarge: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.primary),
      titleTextStyle: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textDarkPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.r8)),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.p24, vertical: AppDimens.p12),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.backgroundLight,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.backgroundLight,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
      displayMedium: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
      displaySmall: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
      headlineMedium: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
      titleLarge: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
      bodyLarge: GoogleFonts.lato(fontSize: 16, color: AppColors.textDarkPrimary),
      bodyMedium: GoogleFonts.lato(fontSize: 14, color: AppColors.textDarkSecondary),
      labelLarge: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textLightPrimary),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.textDarkPrimary),
      titleTextStyle: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDarkPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textLightPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.r8)),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.p24, vertical: AppDimens.p12),
        textStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
