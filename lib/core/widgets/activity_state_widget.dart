import 'package:flutter/material.dart';

class ActivityStateWidget extends StatelessWidget {
  const ActivityStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final n = (MediaQuery.of(context).size.width) / 20;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      buildLabel(
          context: context,
          title: 'No disponible',
          color: Color(0xFFF44565),
          size: n),
      const SizedBox(width: 8),
      buildLabel(
          context: context,
          title: 'Seleccionado',
          color: Colors.green,
          size: n),
      const SizedBox(width: 8),
      buildLabel(
          context: context,
          title: 'Disponible',
          color: Colors.white,
          borderColor: Colors.grey,
          size: n)
    ]);
  }

  Widget buildLabel(
      {required BuildContext context,
      required String title,
      required Color color,
      Color borderColor = Colors.transparent,
      required double size}) {
    return Row(children: [
      Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor, width: 1))),
      const SizedBox(width: 8),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black))
    ]);
  }
}
