// ignore_for_file: deprecated_member_use

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
                ? 'Seleccione un horario'
                : 'Confirme su cita';
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
            LinearPercentIndicator(
                percent: page / 4,
                progressColor: const Color(0XFFAF234A),
                backgroundColor: const Color(0XFFAF234A).withOpacity(0.25),
                barRadius: const Radius.circular(8))
          ]);
  }
}
