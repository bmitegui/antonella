import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 6, height: 24, color: Color(0xFFF44565), child: Text('')),
      const SizedBox(width: 8),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium)
    ]);
  }
}
