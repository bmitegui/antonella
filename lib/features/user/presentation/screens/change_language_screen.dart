


import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/user/presentation/widgets/dropdown_language.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;

    return CustomScaffold(
        text: texts.change_language,
        leading: ArrowBack(),
        body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(children: [
              Text(texts.info_change_language,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54)),
              const SizedBox(height: 16),
              const DropdownLanguageWidget()
            ])));
  }
}
