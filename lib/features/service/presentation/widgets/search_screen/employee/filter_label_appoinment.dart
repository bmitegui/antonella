import 'package:flutter/material.dart';

class FilterLabelAppoinment extends StatefulWidget {
  final Function(String) onSelect;
  const FilterLabelAppoinment({super.key, required this.onSelect});

  @override
  State<FilterLabelAppoinment> createState() => _FilterLabelAppoinmentState();
}

class _FilterLabelAppoinmentState extends State<FilterLabelAppoinment> {
  String _filterLabelSelected = 'Recientes';

  @override
  Widget build(BuildContext context) {
    final List data = ['Recientes', 'Nombre', 'Precio'];
    return Row(
        children: data
            .map((value) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            value != _filterLabelSelected
                                ? Color(0xFFFAE2E1)
                                : Color(0xFFF44565))),
                    onPressed: () =>
                        setState(() {
                          _filterLabelSelected = value;
                          widget.onSelect(value);
                        } ),
                    child: Text(value))))
            .toList());
  }
}
