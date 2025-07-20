import 'package:antonella/core/bloc/theme/theme_bloc.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/dropdown_search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DarkModeScreen extends StatelessWidget {
  const DarkModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<ThemeBloc, bool>(builder: (context, state) {
      final selectedItem = state ? texts.activated : texts.disabled;
      return CustomScaffold(
          text: texts.dark_mode,
          leading: ArrowBack(),
          body: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(children: [
                Text(texts.info_dark_mode,
                    style: bodyBlack54Style(context)),
                const SizedBox(height: 16),
                CustomDropdownSearchWidget(
                    showSearchBox: false,
                    selectedItem: selectedItem,
                    title: texts.dark_mode,
                    initialText: texts.select_mode,
                    options: [
                      texts.activated,
                      texts.disabled,
                      // texts.use_system_configuration
                    ],
                    onChange: (value) {
                      context
                          .read<ThemeBloc>()
                          .add(ThemeChanged(value == texts.activated));
                    })
              ])));
    });
  }
}
