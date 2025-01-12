import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff900236),
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
      onSurface: Color(0xff25181a),
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

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff890032),
      surfaceTint: Color(0xffb1254c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc33358),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff712c39),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffae5c6a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff732d00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb04e12),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff25181a),
      onSurfaceVariant: Color(0xff543d40),
      outline: Color(0xff72585c),
      outlineVariant: Color(0xff907477),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2d2e),
      inversePrimary: Color(0xffffb2bc),
      primaryFixed: Color(0xffd03d61),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffae2249),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffae5c6a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff904452),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffbc571b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff9b4000),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffedd4d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xffffe9ea),
      surfaceContainerHigh: Color(0xfffbe2e4),
      surfaceContainerHighest: Color(0xfff5dddf),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4c0018),
      surfaceTint: Color(0xffb1254c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff890032),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff460a1a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff712c39),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3f1500),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff732d00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff321e21),
      outline: Color(0xff543d40),
      outlineVariant: Color(0xff543d40),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3c2d2e),
      inversePrimary: Color(0xffffe6e8),
      primaryFixed: Color(0xff890032),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff600021),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff712c39),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff541524),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff732d00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff501d00),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffedd4d6),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0f1),
      surfaceContainer: Color(0xffffe9ea),
      surfaceContainerHigh: Color(0xfffbe2e4),
      surfaceContainerHighest: Color(0xfff5dddf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb2bc),
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

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb8c1),
      surfaceTint: Color(0xffffb2bc),
      onPrimary: Color(0xff36000f),
      primaryContainer: Color(0xfff5597c),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffb8c1),
      onSecondary: Color(0xff36000f),
      secondaryContainer: Color(0xffcf7785),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffbc9b),
      onTertiary: Color(0xff2c0d00),
      tertiaryContainer: Color(0xffe07235),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1c1012),
      onSurface: Color(0xfffff9f9),
      onSurfaceVariant: Color(0xffe4c3c6),
      outline: Color(0xffba9b9e),
      outlineVariant: Color(0xff997c7f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dddf),
      inversePrimary: Color(0xff920437),
      primaryFixed: Color(0xffffd9dd),
      onPrimaryFixed: Color(0xff2c000b),
      primaryFixedDim: Color(0xffffb2bc),
      onPrimaryFixedVariant: Color(0xff710028),
      secondaryFixed: Color(0xffffd9dd),
      onSecondaryFixed: Color(0xff2c000b),
      secondaryFixedDim: Color(0xffffb2bc),
      onSecondaryFixedVariant: Color(0xff611f2d),
      tertiaryFixed: Color(0xffffdbcb),
      onTertiaryFixed: Color(0xff240900),
      tertiaryFixedDim: Color(0xffffb692),
      onTertiaryFixedVariant: Color(0xff5f2400),
      surfaceDim: Color(0xff1c1012),
      surfaceBright: Color(0xff453537),
      surfaceContainerLowest: Color(0xff170b0d),
      surfaceContainerLow: Color(0xff25181a),
      surfaceContainer: Color(0xff2a1c1e),
      surfaceContainerHigh: Color(0xff352628),
      surfaceContainerHighest: Color(0xff403133),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffff9f9),
      surfaceTint: Color(0xffffb2bc),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb8c1),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9f9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffb8c1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9f8),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffbc9b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1c1012),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffe4c3c6),
      outlineVariant: Color(0xffe4c3c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff5dddf),
      inversePrimary: Color(0xff5b001e),
      primaryFixed: Color(0xffffdfe2),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb8c1),
      onPrimaryFixedVariant: Color(0xff36000f),
      secondaryFixed: Color(0xffffdfe2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb8c1),
      onSecondaryFixedVariant: Color(0xff36000f),
      tertiaryFixed: Color(0xffffe1d4),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffbc9b),
      onTertiaryFixedVariant: Color(0xff2c0d00),
      surfaceDim: Color(0xff1c1012),
      surfaceBright: Color(0xff453537),
      surfaceContainerLowest: Color(0xff170b0d),
      surfaceContainerLow: Color(0xff25181a),
      surfaceContainer: Color(0xff2a1c1e),
      surfaceContainerHigh: Color(0xff352628),
      surfaceContainerHighest: Color(0xff403133),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.primary,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.only(left: 16),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.primary)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.primary)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colorScheme.primary))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              padding: WidgetStateProperty.resolveWith(
                  (_) => const EdgeInsets.all(12)),
              shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                (_) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ))),
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              padding: WidgetStateProperty.resolveWith(
                  (_) => const EdgeInsets.all(12)),
              shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                (_) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ))),
      appBarTheme:
          const AppBarTheme(scrolledUnderElevation: 0, centerTitle: true));

  List<ExtendedColor> get extendedColors => [];
}


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
