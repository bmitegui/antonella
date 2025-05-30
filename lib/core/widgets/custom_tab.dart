import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final int? number;
  final String text;
  const CustomTab({super.key, this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      
        text: text,
        child: number != null
            ? Row(children: [
                Text(text),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFF44565)),
                    child: Text('$number'))
              ])
            : null);
  }
}
