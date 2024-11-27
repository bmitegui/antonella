import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressSearchWidget extends StatelessWidget {
  final int page;
  const ProgressSearchWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final text = page == 1
        ? 'Seleccione el/los sub servicios'
        : page == 2
            ? 'Seleccione una fecha'
            : page == 3
                ? 'Seleccione un horario'
                : 'Confirme su cita';
    return Column(children: [
      Text(text),
      LinearPercentIndicator(
          percent: page / 4,
          progressColor: themeClass.lightPrimaryColor,
          backgroundColor: themeClass.lightPrimaryColor.withOpacity(0.25),
          barRadius: const Radius.circular(8))
    ]);
  }
}
