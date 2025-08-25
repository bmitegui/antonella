import 'package:flutter/material.dart';

class TitleLarge extends StatelessWidget {
  final String text;
  const TitleLarge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(text,
        style: textTheme.titleLarge);
  }
}
