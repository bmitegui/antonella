import 'package:flutter/material.dart';

class QuantitySelectionWidget extends StatefulWidget {
  final int stock;
  final Function(int) onQuantityChanged;
  const QuantitySelectionWidget({super.key, required this.stock, required this.onQuantityChanged});

  @override
  State<QuantitySelectionWidget> createState() => _QuantitySelectionWidgetState();
}

class _QuantitySelectionWidgetState extends State<QuantitySelectionWidget> {
  int value = 1;

  void _increment() {
    if (value < widget.stock) {
      setState(() {
        value++;
        widget.onQuantityChanged(value);
      });
    }
  }

  void _decrement() {
    if (value > 1) {
      setState(() {
        value--;
        widget.onQuantityChanged(value);
      });
    }
  }


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
                _decrement();
              }),
              Center(
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              IconButton(icon:  Icon(Icons.add), onPressed: () { 
                _increment();
               })
            ],
          ),
        ),
      ),
    );
  }
}