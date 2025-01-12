import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: texts.terms_1,
            style: textTheme.bodySmall!.copyWith(color: colorScheme.onSurface),
            children: [
              TextSpan(
                  text: texts.terms_2,
                  style:
                      textTheme.bodySmall!.copyWith(color: colorScheme.primary),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: texts.terms_3,
                  style: textTheme.bodySmall!
                      .copyWith(color: colorScheme.onSurface)),
              TextSpan(
                  text: texts.terms_4,
                  style:
                      textTheme.bodySmall!.copyWith(color: colorScheme.primary),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: '.',
                  style: textTheme.bodySmall!
                      .copyWith(color: colorScheme.onSurface))
            ]));
  }
}
