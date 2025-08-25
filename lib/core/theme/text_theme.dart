import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:antonella/core/theme/responsive_size.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFont,
  String displayFont,
) {
  final base = Theme.of(context).textTheme;

  // Aplica Google Fonts a baseTextTheme
  final bodyText = GoogleFonts.getTextTheme(bodyFont, base);
  final displayText = GoogleFonts.getTextTheme(displayFont, base);

  // Crea un nuevo TextTheme usando displayText como base
  return displayText.copyWith(
    titleLarge: bodyText.titleLarge
        ?.copyWith(fontSize: 18.rf(context), fontWeight: FontWeight.bold),
    titleMedium: bodyText.titleMedium
        ?.copyWith(fontSize: 16.rf(context), fontWeight: FontWeight.bold),
    titleSmall: bodyText.titleSmall
        ?.copyWith(fontSize: 14.rf(context), fontWeight: FontWeight.bold),
    bodyLarge: bodyText.bodyLarge?.copyWith(
      fontSize: 16.rf(context),
    ),
    bodyMedium: bodyText.bodyMedium?.copyWith(
      fontSize: 14.rf(context),
    ),
    bodySmall: bodyText.bodySmall?.copyWith(
      fontSize: 12.rf(context),
    ),
  );
}
