import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/time_picker.dart';
import 'package:flutter/material.dart';

class SelectTimePage extends StatelessWidget {
  const SelectTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          const SizedBox(height: 16),
          Text(texts.select_time_then_continue),
          const SizedBox(height: 32),
          TimePicker()
        ]));
  }
}
