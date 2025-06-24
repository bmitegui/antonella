import 'package:flutter/material.dart';

class QuantitySelectionWidget extends StatefulWidget {
  final int stock;
  final int initialQuantity;
  final Function(int) onQuantityChanged;
  const QuantitySelectionWidget({super.key, required this.stock, required this.initialQuantity, required this.onQuantityChanged});

  @override
  State<QuantitySelectionWidget> createState() => _QuantitySelectionWidgetState();
}

class _QuantitySelectionWidgetState extends State<QuantitySelectionWidget> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increment() {
    if (_quantity < widget.stock) {
      setState(() { _quantity++;
      widget.onQuantityChanged(_quantity);}
      );
    }
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() { _quantity--;
      widget.onQuantityChanged(_quantity);}
      );
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
                  _quantity.toString(),
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