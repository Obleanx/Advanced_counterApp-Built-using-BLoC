import 'package:flutter/material.dart';
// File: lib/core/theme/app_theme.dart

// Helper function to create a theme based on brightness and color scheme
ThemeData getAppTheme(Brightness brightness, ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    // Card theme with elevated design
    cardTheme: CardTheme(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    // Elevated buttons with dynamic colors
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
    // Text theme with custom styles
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -1.5),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
    ),
  );
}
