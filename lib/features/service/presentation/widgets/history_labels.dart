import 'package:flutter/material.dart';

class HistoryLabels extends StatelessWidget {
  final List<String> labels;
  final String selectedLabel;
  final void Function(String) onSelected;
  const HistoryLabels(
      {super.key,
      required this.labels,
      required this.selectedLabel,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: labels.map((label) {
          return ChoiceChip(
              avatar: SizedBox.shrink(),
              avatarBoxConstraints: BoxConstraints.loose(Size.zero),
              labelStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.transparent),
              ),
              backgroundColor: Colors.grey.shade300,
              selectedColor: Color(0xFFF44565),
              label: Text(label),
              selected: selectedLabel == label,
              onSelected: (selected) {
                onSelected(label);
              });
        }).toList());
  }
}
