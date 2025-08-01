import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  const MaterialTheme();

  /// ======== SCHEMES ========
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0Xfff44565),
      surfaceTint: Colors.black54,
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfffae2e1),
      onPrimaryContainer: Color(0xff333333),
      secondary: Color(0xffe596a9),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Colors.white,
      onSecondaryContainer: Colors.black54,
      tertiary: Colors.black54,
      onTertiary: Colors.black54,
      tertiaryContainer: Colors.black54,
      onTertiaryContainer: Colors.black54,
      error: Colors.black54,
      onError: Colors.black54,
      errorContainer: Colors.black54,
      onErrorContainer: Colors.black54,
      surface: Color(0xfff0f0f0),
      onSurface: Color(0Xff333333),
      onSurfaceVariant: Colors.grey,
      outline: Colors.black54,
      outlineVariant: Colors.black54,
      shadow: Colors.black54,
      scrim: Colors.black54,
      inverseSurface: Colors.black54,
      inversePrimary: Colors.black54,
      primaryFixed: Colors.black54,
      onPrimaryFixed: Colors.black54,
      primaryFixedDim: Colors.black54,
      onPrimaryFixedVariant: Colors.black54,
      secondaryFixed: Colors.black54,
      onSecondaryFixed: Colors.black54,
      secondaryFixedDim: Colors.black54,
      onSecondaryFixedVariant: Colors.black54,
      tertiaryFixed: Colors.black54,
      onTertiaryFixed: Colors.black54,
      tertiaryFixedDim: Colors.black54,
      onTertiaryFixedVariant: Colors.black54,
      surfaceDim: Colors.black54,
      surfaceBright: Colors.black54,
      surfaceContainerLowest: Colors.black54,
      surfaceContainerLow: Colors.black54,
      surfaceContainer: Colors.black54,
      surfaceContainerHigh: Colors.black54,
      surfaceContainerHighest: Colors.black54,
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0Xfff44565),
      surfaceTint: Colors.black54,
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfffae2e1),
      onPrimaryContainer: Color(0xff333333),
      secondary: Color(0xffe596a9),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Colors.white,
      onSecondaryContainer: Colors.black54,
      tertiary: Colors.black54,
      onTertiary: Colors.black54,
      tertiaryContainer: Colors.black54,
      onTertiaryContainer: Colors.black54,
      error: Colors.black54,
      onError: Colors.black54,
      errorContainer: Colors.black54,
      onErrorContainer: Colors.black54,
      surface: Color(0xfff0f0f0),
      onSurface: Color(0Xff333333),
      onSurfaceVariant: Colors.grey,
      outline: Colors.black54,
      outlineVariant: Colors.black54,
      shadow: Colors.black54,
      scrim: Colors.black54,
      inverseSurface: Colors.black54,
      inversePrimary: Colors.black54,
      primaryFixed: Colors.black54,
      onPrimaryFixed: Colors.black54,
      primaryFixedDim: Colors.black54,
      onPrimaryFixedVariant: Colors.black54,
      secondaryFixed: Colors.black54,
      onSecondaryFixed: Colors.black54,
      secondaryFixedDim: Colors.black54,
      onSecondaryFixedVariant: Colors.black54,
      tertiaryFixed: Colors.black54,
      onTertiaryFixed: Colors.black54,
      tertiaryFixedDim: Colors.black54,
      onTertiaryFixedVariant: Colors.black54,
      surfaceDim: Colors.black54,
      surfaceBright: Colors.black54,
      surfaceContainerLowest: Colors.black54,
      surfaceContainerLow: Colors.black54,
      surfaceContainer: Colors.black54,
      surfaceContainerHigh: Colors.black54,
      surfaceContainerHighest: Colors.black54,
    );
  }

  /// ======== THEMES ========
  ThemeData light(BuildContext context) => _buildTheme(lightScheme(), context);
  ThemeData dark(BuildContext context) => _buildTheme(darkScheme(), context);

  ThemeData _buildTheme(ColorScheme colorScheme, BuildContext context) {
    final textTheme = _buildTextTheme(colorScheme, context);

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      cardTheme: CardTheme(color: colorScheme.onPrimary),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colorScheme.primary),
          foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
          padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
    );
  }

  /// ======== TEXT THEME ========
  TextTheme _buildTextTheme(ColorScheme colorScheme, BuildContext context) {
    final base = Theme.of(context).textTheme;
    final bodyText = GoogleFonts.getTextTheme("Rubik", base);
    final displayText = GoogleFonts.getTextTheme("Rubik", base);

    final customTextTheme = displayText.copyWith(
      titleLarge: bodyText.titleLarge?.copyWith(
        fontSize: 18.rf(context),
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      titleMedium: bodyText.titleMedium?.copyWith(
        fontSize: 16.rf(context),
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      titleSmall: bodyText.titleSmall?.copyWith(
        fontSize: 14.rf(context),
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      bodyLarge: bodyText.bodyLarge?.copyWith(
        fontSize: 16.rf(context),
        color: colorScheme.onSurface,
      ),
      bodyMedium: bodyText.bodyMedium?.copyWith(
        fontSize: 14.rf(context),
        color: colorScheme.onSurface,
      ),
      bodySmall: bodyText.bodySmall?.copyWith(
        fontSize: 12.rf(context),
        color: colorScheme.onSurface,
      ),
    );
    return customTextTheme.apply(
      displayColor: colorScheme.primary,
    );
  }
}
