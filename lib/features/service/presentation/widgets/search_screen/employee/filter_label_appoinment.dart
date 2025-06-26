import 'package:flutter/material.dart';

class FilterLabelAppoinment extends StatefulWidget {
  const FilterLabelAppoinment({super.key});

  @override
  State<FilterLabelAppoinment> createState() => _FilterLabelAppoinmentState();
}

class _FilterLabelAppoinmentState extends State<FilterLabelAppoinment> {
  String _filterLabelSelected = 'Recientes';

  @override
  Widget build(BuildContext context) {
    final List data = ['Recientes', 'Nombre', 'Horas', 'Código'];
    return Wrap(
        runSpacing: 8,
        spacing: 8,
        alignment: WrapAlignment.center,
        children: data
            .map((value) => FilledButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        value != _filterLabelSelected
                            ? Color(0xFFFAE2E1)
                            : Color(0xFFF44565))),
                onPressed: () => setState(() => _filterLabelSelected = value),
                child: Text(value)))
            .toList());
  }
}
