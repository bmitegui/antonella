import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  const MaterialTheme();

  /// ======== SCHEMES ========
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF44565), // Mantienes tu tono principal
      surfaceTint: Color(0xFFF44565),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD9DF),
      onPrimaryContainer: Color(0xFF3A0014),

      secondary: Color(0xFFE596A9), // Mantienes tu secundario
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFFD9E2),
      onSecondaryContainer: Color(0xFF3B0022),

      // Nuevos colores para los que pediste
      tertiary: Color(0xFF7A5E9A), // Lila suave para contraste
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFEBD7FF),
      onTertiaryContainer: Color(0xFF2D004D),

      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      surface: Color(0xFFF0F0F0), // Mantienes tu surface
      onSurface: Color(0xFF333333), // Mantienes
      onSurfaceVariant: Color(0xFF757575), // Mantienes

      outline: Color(0xFF8F8F8F),
      outlineVariant: Color(0xFFCACACA),
      shadow: Color(0x33000000),
      scrim: Color(0xFF000000),

      inverseSurface: Color(0xFF2F3033),
      inversePrimary: Color(0xFFFFB2C0),

      primaryFixed: Color(0xFFFFB2C0),
      onPrimaryFixed: Color(0xFF3A0014),
      primaryFixedDim: Color(0xFFE58EA3),
      onPrimaryFixedVariant: Color(0xFF5C1227),

      secondaryFixed: Color(0xFFFFB2C0),
      onSecondaryFixed: Color(0xFF3B0022),
      secondaryFixedDim: Color(0xFFE58EA3),
      onSecondaryFixedVariant: Color(0xFF5B1135),

      tertiaryFixed: Color(0xFFD3B9FF),
      onTertiaryFixed: Color(0xFF2D004D),
      tertiaryFixedDim: Color(0xFFB39BE0),
      onTertiaryFixedVariant: Color(0xFF48286D),

      surfaceDim: Color(0xFFE6E6E6),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF9F9F9),
      surfaceContainer: Color(0xFFF3F3F3),
      surfaceContainerHigh: Color(0xFFEEEEEE),
      surfaceContainerHighest: Color(0xFFE8E8E8),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFF44565), // Mantienes tu tono principal
      surfaceTint: Color(0xFFF44565),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD9DF),
      onPrimaryContainer: Color(0xFF3A0014),

      secondary: Color(0xFFE596A9), // Mantienes tu secundario
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFFD9E2),
      onSecondaryContainer: Color(0xFF3B0022),

      // Nuevos colores para los que pediste
      tertiary: Color(0xFF7A5E9A), // Lila suave para contraste
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFEBD7FF),
      onTertiaryContainer: Color(0xFF2D004D),

      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      surface: Color(0xFFF0F0F0), // Mantienes tu surface
      onSurface: Color(0xFF333333), // Mantienes
      onSurfaceVariant: Color(0xFF757575), // Mantienes

      outline: Color(0xFF8F8F8F),
      outlineVariant: Color(0xFFCACACA),
      shadow: Color(0x33000000),
      scrim: Color(0xFF000000),

      inverseSurface: Color(0xFF2F3033),
      inversePrimary: Color(0xFFFFB2C0),

      primaryFixed: Color(0xFFFFB2C0),
      onPrimaryFixed: Color(0xFF3A0014),
      primaryFixedDim: Color(0xFFE58EA3),
      onPrimaryFixedVariant: Color(0xFF5C1227),

      secondaryFixed: Color(0xFFFFB2C0),
      onSecondaryFixed: Color(0xFF3B0022),
      secondaryFixedDim: Color(0xFFE58EA3),
      onSecondaryFixedVariant: Color(0xFF5B1135),

      tertiaryFixed: Color(0xFFD3B9FF),
      onTertiaryFixed: Color(0xFF2D004D),
      tertiaryFixedDim: Color(0xFFB39BE0),
      onTertiaryFixedVariant: Color(0xFF48286D),

      surfaceDim: Color(0xFFE6E6E6),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF9F9F9),
      surfaceContainer: Color(0xFFF3F3F3),
      surfaceContainerHigh: Color(0xFFEEEEEE),
      surfaceContainerHighest: Color(0xFFE8E8E8),
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
      cardTheme: CardThemeData(color: colorScheme.onPrimary),
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
