import 'package:flutter/material.dart';

class StatusLabelAppointment extends StatelessWidget {
  const StatusLabelAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {'title': 'Pendientes', 'cant': 5, 'color': Color(0xFFFBB03B)},
      {'title': 'En curso', 'cant': 1, 'color': Color(0xFF39B44A)},
      {'title': 'Finalizadas', 'cant': 2, 'color': Color(0xFF0070BA)}
    ];
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: data
            .map((element) => Column(children: [
                  Container(
                      width: 92,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: element['color'],
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(element['cant'].toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white))),
                  const SizedBox(height: 8),
                  Text(element['title'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black54))
                ]))
            .toList());
  }
}
