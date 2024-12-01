import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTitleSeparatorWidget extends StatelessWidget {
  final String text;
  final String? description;
  const CustomTitleSeparatorWidget(
      {super.key, required this.text, this.description});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          color: themeClass.lightPrimaryColor,
          width: 4,
          child: Text('', style: Theme.of(context).textTheme.titleMedium)),
      const SizedBox(width: 4),
      Text(text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      if (description != null) const SizedBox(width: 8),
      if (description != null)
        Expanded(
            child: Text(description!,
                maxLines: 2, overflow: TextOverflow.ellipsis))
    ]);
  }
}
