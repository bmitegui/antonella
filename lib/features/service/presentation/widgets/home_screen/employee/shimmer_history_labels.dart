import 'package:antonella/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerHistoryLabels extends StatelessWidget {
  const ShimmerHistoryLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: ['Semanal', 'Mensual', 'Anual'].map((label) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomShimmer(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                child: Text(label)),
          );
        }).toList());
  }
}
