import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String? description;
  final String? index;
  const CustomTitle(
      {super.key, required this.title, this.description, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      (index == null)
          ? Container(
              width: 6, height: 24, color: Color(0xFFF44565), child: Text(''))
          : CircleAvatar(
              backgroundColor: Color(0xFFF44565),
              child: Text(index!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white))),
      const SizedBox(width: 8),
      Expanded(
          child: Row(children: [
        Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
        const SizedBox(width: 8),
        if (description != null) Expanded(child: Text(description!))
      ]))
    ]);
  }
}
