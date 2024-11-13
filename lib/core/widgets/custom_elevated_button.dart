import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final Widget child;
  const CustomElevatedButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith(
                (_) => themeClass.lightSixthColor),
            backgroundColor:
                WidgetStateProperty.resolveWith<Color>((_) => Colors.white),
            foregroundColor:
                WidgetStateProperty.all(themeClass.lightPrimaryColor),
            shape: WidgetStateProperty.resolveWith<OutlinedBorder>((_) =>
                RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.5, color: themeClass.lightPrimaryColor),
                    borderRadius: BorderRadius.circular(16)))),
        onPressed: onPressed,
        child: child);
  }
}
