import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StatusLegend extends StatelessWidget {
  const StatusLegend({super.key});

  Widget _buildLegendItem(Color color, String text) {
    return Row(children: [
      Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
      const SizedBox(width: 4),
      Text(text)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _buildLegendItem(Colors.green, 'Seleccionado'),
      const Spacer(),
      _buildLegendItem(
          themeClass.lightTertiaryColor, 'Disponibles')
    ]);
  }
}
