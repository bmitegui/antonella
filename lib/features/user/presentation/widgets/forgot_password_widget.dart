import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {},
            child: Text(texts.forgot_password,
                style: textTheme.bodySmall!
                    .copyWith(color: colorScheme.primary))));
  }
}
