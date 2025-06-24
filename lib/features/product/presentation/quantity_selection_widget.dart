import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:flutter/material.dart';

class QuantitySelectionWidget extends StatefulWidget {
  final ProductEntity productEntity;
  final int quantity;
  const QuantitySelectionWidget(
      {super.key, required this.productEntity, required this.quantity});

  @override
  State<QuantitySelectionWidget> createState() =>
      _QuantitySelectionWidgetState();
}

class _QuantitySelectionWidgetState extends State<QuantitySelectionWidget> {
  void _increment() {
    if (widget.quantity < widget.productEntity.stock) {
      sl<ProductsSelectedBloc>().add(UpdateProductQuantityEvent(
          product: widget.productEntity, newQuantity: widget.quantity + 1));
    }
  }

  void _decrement() {
    if (widget.quantity > 1) {
      sl<ProductsSelectedBloc>().add(UpdateProductQuantityEvent(
          product: widget.productEntity, newQuantity: widget.quantity - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                      icon: Icon(Icons.remove), onPressed: () => _decrement()),
                  Center(
                      child: Text(widget.quantity.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.black))),
                  IconButton(
                      icon: Icon(Icons.add), onPressed: () => _increment())
                ]))));
  }
}
