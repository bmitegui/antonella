import 'package:antonella/features/product/domain/entities/product_entity.dart';

class CartItem {
  final ProductEntity product;
  final int quantity;
  

  CartItem({required this.product, required this.quantity});
}
