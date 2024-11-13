import 'package:flutter/material.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const RememberMeWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('Recuérdame para la próxima vez',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.bold)),
      const Spacer(),
      Switch(value: value, onChanged: onChanged)
    ]);
  }
}
