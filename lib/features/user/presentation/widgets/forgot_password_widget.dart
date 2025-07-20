import 'package:flutter/material.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () => GoRouter.of(context).go('/forgotPassword'),
            child: Text(texts.forgot_password,
                style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline))));
  }
}
