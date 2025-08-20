import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color textColor;
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      this.backgroundColor = const Color(0xFFF44565),
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: backgroundColor,
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: textColor)));
  }
}
