import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? onTap;
  final Color? color;
  final double? size;
  const CustomIconButton(
      {super.key, required this.iconData, this.onTap, this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: color ?? themeClass.lightTertiaryColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 1)
                ]),
            child: Icon(iconData, color: Colors.white, size: size)));
  }
}
