import "package:antonella/core/bloc/language/language_bloc.dart";
import "package:antonella/core/injection/injection_container.dart";
import "package:antonella/core/l10n/app_localizations.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class DropdownLanguageWidget extends StatelessWidget {
  const DropdownLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<LanguageBloc, Locale>(builder: (context, stateLanguage) {
      return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: DropdownMenu(
              initialSelection: stateLanguage,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
              inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorScheme.primary),
                      borderRadius: BorderRadius.circular(8)),
                  labelStyle: Theme.of(context).textTheme.bodySmall),
              menuStyle: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      colorScheme.onPrimary),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)))),
              leadingIcon: Icon(Icons.language, color: colorScheme.primary),
              width: double.infinity,
              label: Text(texts.change_language,
                  style: Theme.of(context).textTheme.bodyMedium),
              dropdownMenuEntries: [
                DropdownMenuEntry(
                    value: const Locale('en'), label: texts.english),
                DropdownMenuEntry(
                    value: const Locale('es'), label: texts.spanish)
              ],
              onSelected: (value) {
                if (value != null) {
                  sl<LanguageBloc>().add(LanguageChanged(value));
                }
              }));
    });
  }
}
