import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/service/presentation/widgets/detail_service_screen/build_cart_item.dart';
import 'package:flutter/material.dart';

class ProductsSelectedListWidget extends StatelessWidget {
  final List<ProductEntity> products;
  final void Function(ProductEntity product, int quantity) onQuantityChanged;

  const ProductsSelectedListWidget({
    super.key,
    required this.products,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Agrupar productos por id (porque pueden repetirse)
    final Map<String, List<ProductEntity>> grouped = {};
    for (var p in products) {
      grouped.putIfAbsent(p.id, () => []).add(p);
    }

    final uniqueProducts = grouped.keys.map((id) => grouped[id]!.first).toList();

    return Column(
      children: uniqueProducts.map((product) {
        final quantity = grouped[product.id]!.length;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: BuildCartItem(
            productEntity: product,
            quantity: quantity,
            onQuantityChanged: (value) {
              onQuantityChanged(product, value);
            },
          ),
        );
      }).toList(),
    );
  }
}
