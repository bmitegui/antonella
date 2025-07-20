import 'package:antonella/core/utils/util.dart';
import 'package:flutter/material.dart';

class ListTitleSettings extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Widget? goTo;
  final void Function()? onTap;
  const ListTitleSettings(
      {super.key,
      required this.text,
      required this.iconData,
      this.goTo,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
        leading: Icon(iconData, color: colorScheme.onSurface),
        title: Text(text,
            style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
        onTap: onTap ?? () => navigateWithSlideTransition(context, goTo!));
  }
}
