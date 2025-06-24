import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  const MaterialTheme();

  /// ======== SCHEMES ========
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0XFFF44565),
      surfaceTint: Color(0xffb1254c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc33358),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff934654),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffaab6),
      onSecondaryContainer: Color(0xff5c1b2a),
      tertiary: Color(0xff7a3100),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb04e12),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f7),
      onSurface: Color(0XFF333333),
      onSurfaceVariant: Color(0xff584144),
      outline: Color(0xff8c7073),
      outlineVariant: Color(0xffe0bec2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2d2e),
      inversePrimary: Color(0xffffb2bc),
      primaryFixed: Color(0xffffd9dd),
      onPrimaryFixed: Color(0xff400013),
      primaryFixedDim: Color(0xffffb2bc),
      onPrimaryFixedVariant: Color(0xff900235),
      secondaryFixed: Color(0xffffd9dd),
      onSecondaryFixed: Color(0xff3d0414),
      secondaryFixedDim: Color(0xffffb2bc),
      onSecondaryFixedVariant: Color(0xff762f3d),
      tertiaryFixed: Color(0xffffdbcb),
      onTertiaryFixed: Color(0xff341100),
      tertiaryFixedDim: Color(0xffffb692),
      onTertiaryFixedVariant: Color(0xff7a3000),
      surfaceDim: Color(0xffedd4d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xffffe9ea),
      surfaceContainerHigh: Color(0xfffbe2e4),
      surfaceContainerHighest: Color(0xfff5dddf),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0XFFF44565),
      surfaceTint: Color(0xffffb2bc),
      onPrimary: Color(0xff670023),
      primaryContainer: Color(0xffa31842),
      onPrimaryContainer: Color(0xfffff4f4),
      secondary: Color(0xffffb2bc),
      onSecondary: Color(0xff591928),
      secondaryContainer: Color(0xff6a2634),
      onSecondaryContainer: Color(0xffffc2c9),
      tertiary: Color(0xffffb692),
      onTertiary: Color(0xff562000),
      tertiaryContainer: Color(0xff8d3900),
      onTertiaryContainer: Color(0xfffff2ee),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1c1012),
      onSurface: Color(0xfff5dddf),
      onSurfaceVariant: Color(0xffe0bec2),
      outline: Color(0xffa7898d),
      outlineVariant: Color(0xff584144),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dddf),
      inversePrimary: Color(0xffb1254c),
      primaryFixed: Color(0xffffd9dd),
      onPrimaryFixed: Color(0xff400013),
      primaryFixedDim: Color(0xffffb2bc),
      onPrimaryFixedVariant: Color(0xff900235),
      secondaryFixed: Color(0xffffd9dd),
      onSecondaryFixed: Color(0xff3d0414),
      secondaryFixedDim: Color(0xffffb2bc),
      onSecondaryFixedVariant: Color(0xff762f3d),
      tertiaryFixed: Color(0xffffdbcb),
      onTertiaryFixed: Color(0xff341100),
      tertiaryFixedDim: Color(0xffffb692),
      onTertiaryFixedVariant: Color(0xff7a3000),
      surfaceDim: Color(0xff1c1012),
      surfaceBright: Color(0xff453537),
      surfaceContainerLowest: Color(0xff170b0d),
      surfaceContainerLow: Color(0xff25181a),
      surfaceContainer: Color(0xff2a1c1e),
      surfaceContainerHigh: Color(0xff352628),
      surfaceContainerHighest: Color(0xff403133),
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
      ),
      titleMedium: bodyText.titleMedium?.copyWith(
        fontSize: 16.rf(context),
        fontWeight: FontWeight.bold,
      ),
      titleSmall: bodyText.titleSmall?.copyWith(
        fontSize: 14.rf(context),
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: bodyText.bodyLarge?.copyWith(
        fontSize: 16.rf(context),
      ),
      bodyMedium: bodyText.bodyMedium?.copyWith(
        fontSize: 14.rf(context),
      ),
      bodySmall: bodyText.bodySmall?.copyWith(
        fontSize: 12.rf(context),
      ),
      labelLarge: bodyText.labelLarge?.copyWith(
        fontSize: 14.rf(context),
        fontWeight: FontWeight.w600,
      ),
    );

    return customTextTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.primary,
    );
  }

  /// (Opcional, si vas a usar colores extendidos)
  List<ExtendedColor> get extendedColors => [];
}

/// Modelo extendido de colores opcional
class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
