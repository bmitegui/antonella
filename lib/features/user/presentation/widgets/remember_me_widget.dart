import 'package:antonella/core/widgets/circle_check_box.dart';
import 'package:flutter/material.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const RememberMeWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Row(children: [
      CircleCheckbox(checked: value, onTap: onChanged),
      const SizedBox(width: 8),
      Text('Recuérdame',
          style: textTheme.bodySmall!.copyWith(
              color: colorScheme.onSurface, fontWeight: FontWeight.bold))
    ]);
  }
}
