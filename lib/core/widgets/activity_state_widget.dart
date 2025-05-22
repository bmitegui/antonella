import 'package:flutter/material.dart';

class ActivityStateWidget extends StatelessWidget {
  const ActivityStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final n = (MediaQuery.of(context).size.width) / 16;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      buildLabel(title: 'No disponible', color: Colors.pinkAccent, size: n),
      buildLabel(title: 'Seleccionado', color: Colors.green, size: n),
      buildLabel(
          title: 'Disponible',
          color: Colors.white,
          borderColor: Colors.grey,
          size: n)
    ]);
  }

  Widget buildLabel(
      {required String title,
      required Color color,
      Color borderColor = const Color(0xFFFFFFFF),
      required double size}) {
    return Row(children: [
      Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor, width: 2.0))),
      const SizedBox(width: 8),
      Text(title)
    ]);
  }
}
