import 'package:flutter/material.dart';
import '../../features/branding/domain/branding_model.dart';

class AppTheme {
  AppTheme._();

  static ThemeData fromBranding(BrandingModel branding) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: branding.primaryColor,
      primary: branding.primaryColor,
      secondary: branding.secondaryColor,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: branding.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: branding.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  static ThemeData get fallback => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    textTheme: _textTheme,
  );

  /// Design system typography tokens.
  ///
  /// Mapping from HTML design:
  ///   displaySmall   → headline-lg  (32px / fw600)
  ///   headlineMedium → headline-md  (24px / fw600)
  ///   headlineSmall  → headline-sm  (20px / fw500)
  ///   bodyLarge      → body-lg      (18px / fw400)
  ///   bodyMedium     → body-md      (16px / fw400)
  ///   bodySmall      → body-sm      (14px / fw400)
  ///   labelLarge     → label-bold   (12px / fw700 / ls0.6)
  ///   labelSmall     → label-caps   (11px / fw600 / ls0.88)
  static const TextTheme _textTheme = TextTheme(
    displaySmall: TextStyle(
      fontSize: 32,
      height: 1.25,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      height: 1.333,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      height: 1.4,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      height: 1.556,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      height: 1.429,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      height: 1.333,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      height: 1.273,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.88,
    ),
  );
}
