import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTitleSeparatorWidget extends StatelessWidget {
  final String text;
  final String? description;
  final String? indexForm;
  const CustomTitleSeparatorWidget(
      {super.key, required this.text, this.description, this.indexForm = ' '});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      (indexForm!.trim().isEmpty)
          ? Container(
              decoration: BoxDecoration(color: themeClass.lightPrimaryColor),
              child: Text(indexForm!,
                  style: Theme.of(context).textTheme.titleMedium))
          : CircleAvatar(
              backgroundColor: themeClass.lightPrimaryColor,
              child: Text(indexForm!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white))),
      const SizedBox(width: 4),
      Expanded(
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold))),
      if (description != null) const SizedBox(width: 8),
      if (description != null)
        Expanded(
            child: Text(description!,
                maxLines: 2, overflow: TextOverflow.ellipsis))
    ]);
  }
}
