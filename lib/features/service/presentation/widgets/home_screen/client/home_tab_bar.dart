import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_tab.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  final TabController controller;
  const HomeTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    return TabBar(
        unselectedLabelColor: Colors.black,
        indicatorColor: colorScheme.primary,
        dividerColor: colorScheme.onSurfaceVariant,
        controller: controller,
        labelColor: colorScheme.primary,
        tabs: [
          CustomTab(text: texts.services),
          CustomTab(text: texts.products)
        ]);
  }
}
