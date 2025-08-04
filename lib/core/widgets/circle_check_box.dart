import 'package:flutter/material.dart';

class CircleCheckbox extends StatefulWidget {
  final bool checked;
  final Function(bool) onTap;
  const CircleCheckbox({super.key, required this.checked, required this.onTap});

  @override
  State<CircleCheckbox> createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
        onTap: () => widget.onTap(!widget.checked),
        child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: colorScheme.secondaryContainer),
            child: widget.checked
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        color: colorScheme.primary))
                : null));
  }
}
