import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuilCartItem extends StatefulWidget {
  final String imageUrl;
  final ProductEntity product;
  final int quantity;

  const BuilCartItem({
    super.key, 
    required this.imageUrl,
    required this.product,
    required this.quantity});

  @override
  State<BuilCartItem> createState() => _BuilCartItemState();
}

class _BuilCartItemState extends State<BuilCartItem> {
  @override
  Widget build(BuildContext context) {
    int selectedQuantity = widget.quantity;
    return BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
      builder: (context, state) {
        return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Image.network(widget.imageUrl, width: 60, height: 60),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(widget.product.nombre,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Cant $selectedQuantity')
              ])),
          Column(children: [
            QuantitySelectionWidget(stock: widget.product.stock, onQuantityChanged: (quantityProduct) {
                        setState(() {
                          selectedQuantity = quantityProduct;
                        });
                      },
            ),
            SizedBox(height: 40),
            Text('${widget.product.price}', style: const TextStyle(fontWeight: FontWeight.bold))
          ])
        ]));
      }
    );
  }
}