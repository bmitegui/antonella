import 'package:flutter/material.dart';

class CategoryService extends StatelessWidget {
  final String title;
  const CategoryService({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 6, height: 32, color: Color(0xFFF44565), child: Text('')),
      const SizedBox(width: 8),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold))
    ]);
  }
}
