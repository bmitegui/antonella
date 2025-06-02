import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final int? number;
  final String text;
  const CustomTab({super.key, this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
        icon: number != null
            ? Row(children: [
                Text(text),
                const SizedBox(width: 4),
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF44565)),
                    child: Text('$number',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)))
              ])
            : null,
        text: number == null ? text : null);
  }
}
