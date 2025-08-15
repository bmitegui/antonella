import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class QuantitySelectionWidget extends StatefulWidget {
  final ProductEntity productEntity;
  final int quantity;
  final void Function(int)? onChanged;

  const QuantitySelectionWidget(
      {super.key, required this.productEntity, required this.quantity, this.onChanged});

  @override
  State<QuantitySelectionWidget> createState() =>
      _QuantitySelectionWidgetState();
}

class _QuantitySelectionWidgetState extends State<QuantitySelectionWidget> {
  late int localQuantity;

  @override
  void initState() {
    super.initState();
    localQuantity = widget.quantity;
  }

  void _increment() {
    if (localQuantity < widget.productEntity.stock) {
      setState(() { localQuantity++;
      widget.onChanged!(localQuantity);}
      );
    }
  }

  void _decrement() {
    if (localQuantity > 1) {
      setState(() { localQuantity--;
      widget.onChanged!(localQuantity);}
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
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                      icon: Icon(Icons.remove), onPressed: () => _decrement()),
                  Center(
                      child: Text(localQuantity.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.black))),
                  IconButton(
                      icon: Icon(Icons.add), onPressed: () => _increment())
                ]))));
  }
}
