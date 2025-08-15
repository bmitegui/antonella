import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressSearchWidget extends StatelessWidget {
  final int page;
  const ProgressSearchWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final text = page == 1
        ? 'Seleccione un sub-servicio'
        : page == 2
            ? 'Seleccione una fecha'
            : page == 3
                ? 'Seleccione una hora'
                : 'Confirme su orden';
    return page == 1
        ? Align(
            alignment: Alignment.center,
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey)))
        : Column(children: [
            Text(text),
            const SizedBox(height: 4),
            LinearPercentIndicator(
                lineHeight: 8,
                percent: page / 4,
                progressColor: const Color(0xFFF44565),
                backgroundColor: Colors.grey.shade400,
                barRadius: const Radius.circular(8))
          ]);
  }
}
