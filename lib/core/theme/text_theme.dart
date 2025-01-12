import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;

  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);

  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge!
        .copyWith(fontSize: 16.rf(context), fontWeight: FontWeight.bold),
    bodyMedium: bodyTextTheme.bodyMedium!.copyWith(fontSize: 14.rf(context)),
    bodySmall: bodyTextTheme.bodySmall!.copyWith(fontSize: 12.rf(context)),
    labelLarge: bodyTextTheme.labelLarge!.copyWith(fontSize: 14.rf(context)),
    labelMedium: bodyTextTheme.labelMedium!.copyWith(fontSize: 12.rf(context)),
    labelSmall: bodyTextTheme.labelSmall!.copyWith(fontSize: 11.rf(context)),
  );

  return textTheme;
}
