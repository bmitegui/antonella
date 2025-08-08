import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextFormatWidget extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final Icon prefixIcon;
  final TextInputType? type;
  final List<TextInputFormatter>? formatters;
  final double width;
  final void Function(String)? onChanged;
  const CardTextFormatWidget(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.prefixIcon,
      this.formatters,
      required this.width, 
      this.onChanged, 
      this.type});

  @override
  State<CardTextFormatWidget> createState() => _CardTextFormatWidgetState();
}

class _CardTextFormatWidgetState extends State<CardTextFormatWidget> {
  late String text;

  @override
  void initState() {
    super.initState();
    text = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width / 1.12,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: (widget.type == null) ? TextInputType.number : widget.type,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            prefixIcon: widget.prefixIcon),
        inputFormatters: widget.formatters,
        onChanged: (widget.onChanged == null) ? (value) {
          var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
          setState(() {
            widget.textController.value = widget.textController.value.copyWith(
                text: text,
                selection: TextSelection.collapsed(offset: text.length),
                composing: TextRange.empty);
          });
        } : widget.onChanged,
      ),
    );
  }
}
