import 'package:antonella/features/product/domain/entities/cart_item.dart';

class CartModel extends CartItem{
  CartModel({required super.product, required super.quantity});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: json['product_id'], 
      quantity: json['quantity']
    );
  }
}