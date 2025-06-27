import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class ProgressStatusLabel extends StatelessWidget {
  final ProgressStatus status;

  const ProgressStatusLabel({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    String label;

    switch (status) {
      case ProgressStatus.pendiente:
        bgColor = Colors.orange;
        label = 'Pendiente';
        break;
      case ProgressStatus.enProgreso:
        bgColor = Colors.green;
        label = 'En curso';
        break;
      case ProgressStatus.finalizado:
        bgColor = Colors.blue;
        label = 'Finalizado';
        break;
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
        ),
        child: Text(label,
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  }
}
