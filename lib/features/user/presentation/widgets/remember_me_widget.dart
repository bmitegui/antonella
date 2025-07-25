import 'package:antonella/core/widgets/circle_check_box.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const RememberMeWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(children: [
      CircleCheckbox(checked: value, onTap: onChanged),
      const SizedBox(width: 8),
      Text(texts.remember_me,
          style: textTheme.bodySmall!.copyWith(
              color: colorScheme.onSurface, fontWeight: FontWeight.bold))
    ]);
  }
}
