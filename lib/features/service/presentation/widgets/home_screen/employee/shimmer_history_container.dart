import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerHistoryContainer extends StatelessWidget {
  const ShimmerHistoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomShimmer(
        padding: EdgeInsets.all(8),
        borderRadius: 16,
        child: Row(children: [
          const SizedBox(width: 40, height: 40),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                Text(texts.total_billed,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('\$0.0',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold))
              ]))
        ]));
  }
}
