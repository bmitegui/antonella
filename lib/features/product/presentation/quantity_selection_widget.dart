import 'package:flutter/material.dart';

class QuantitySelectionWidget extends StatefulWidget {
  final int stock;
  const QuantitySelectionWidget({super.key, required this.stock});

  @override
  State<QuantitySelectionWidget> createState() => _QuantitySelectionWidgetState();
}

class _QuantitySelectionWidgetState extends State<QuantitySelectionWidget> {
  int value = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(icon:  Icon(Icons.remove), onPressed: () {
                setState(() {
                  value--;
                  if(value < 1) value = 1;
                });
              },),
              Center(
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              IconButton(icon:  Icon(Icons.add), onPressed: () { setState(() {
                if (value < widget.stock) {
                  value++;
                }
              }); })
            ],
          ),
        ),
      ),
    );
  }
}