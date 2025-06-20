part of 'cart_bloc.dart';


sealed class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final List<ProductEntity> products;

  AddToCart({required this.products});
}

