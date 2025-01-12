import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const RememberMeWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return Row(children: [
      Text(texts.remember_me),
      const Spacer(),
      Switch(value: value, onChanged: onChanged)
    ]);
  }
}
