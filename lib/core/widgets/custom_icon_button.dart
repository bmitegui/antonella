import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  const CustomIconButton(
      {super.key, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: themeClass.lightTertiaryColor,
                borderRadius: BorderRadius.circular(16)),
            child: Icon(iconData, color: Colors.white)));
  }
}
