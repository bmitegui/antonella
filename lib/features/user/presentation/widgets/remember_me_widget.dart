import 'package:flutter/material.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const RememberMeWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    //final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      Text('Recuérdame', style: textTheme.bodySmall!
                    .copyWith(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
      //const Spacer(),
      //Switch(value: value, onChanged: onChanged)
    ]);
  }
}
