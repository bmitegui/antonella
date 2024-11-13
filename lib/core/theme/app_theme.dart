import 'package:antonella/core/theme/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  Color lightPrimaryColor = const Color(0XFFAF234A);
  Color lightSecondaryColor = const Color(0XFFC9285D);
  Color lightTertiaryColor = const Color(0XFFBD818E);
  Color lightQuaternaryColor = const Color(0XFFC99EAC);
  Color lightQuinaryColor = const Color(0XFFF3B4C7);

  Color lightSixthColor = const Color(0XFFD3C7CB);
  Color lightSeventhColor = const Color(0XFFADADAD);
  Color lightEighthColor = const Color(0XFF484850);

  Color lightscaffoldBackgroundColor = Colors.white;

  ThemeData getTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: themeClass.lightPrimaryColor,
      scaffoldBackgroundColor: themeClass.lightscaffoldBackgroundColor,
      switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(Colors.white),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return themeClass.lightPrimaryColor;
            }
            return null;
          })),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.rubik().copyWith(
              fontSize: 30.rf(context),
              fontWeight: FontWeight.bold,
              color: themeClass.lightPrimaryColor),
          titleMedium: GoogleFonts.rubik().copyWith(
              fontSize: 20.rf(context),
              fontWeight: FontWeight.bold,
              color: themeClass.lightPrimaryColor),
          titleSmall: GoogleFonts.rubik().copyWith(
              fontSize: 15.rf(context),
              fontWeight: FontWeight.bold,
              color: themeClass.lightPrimaryColor),
          bodyLarge: GoogleFonts.rubik().copyWith(
              fontSize: 20.rf(context), color: themeClass.lightEighthColor),
          bodyMedium: GoogleFonts.rubik().copyWith(
              fontSize: 15.rf(context), color: themeClass.lightEighthColor),
          bodySmall: GoogleFonts.rubik().copyWith(
              fontSize: 12.rf(context), color: themeClass.lightEighthColor)),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith(
                  (_) => themeClass.lightSecondaryColor),
              padding: WidgetStateProperty.resolveWith(
                  (_) => EdgeInsets.all(16.rf(context))),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              textStyle: WidgetStateProperty.resolveWith((_) => TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15.rf(context))),
              minimumSize:
                  WidgetStateProperty.all(const Size(double.infinity, 0)),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (_) => themeClass.lightPrimaryColor),
              shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) =>
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.rf(context)))))));
}

ThemeClass themeClass = ThemeClass();
