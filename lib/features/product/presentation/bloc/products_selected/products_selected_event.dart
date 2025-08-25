part of 'products_selected_bloc.dart';

sealed class ProductsSelectedEvent {
  const ProductsSelectedEvent();
}

final class ProductSelectedInitialEvent extends ProductsSelectedEvent {}

final class AddProductEvent extends ProductsSelectedEvent {
  final ProductEntity product;
  final int cant;
  AddProductEvent({required this.product, required this.cant});
}

class UpdateProductQuantityEvent extends ProductsSelectedEvent {
  final ProductEntity product;
  final int newQuantity;

  UpdateProductQuantityEvent({
    required this.product,
    required this.newQuantity,
  });
}


final class DeleteProductEvent extends ProductsSelectedEvent {
  final ProductEntity product;
  DeleteProductEvent({required this.product});
}

final class ClearProductSelectedEvent extends ProductsSelectedEvent {}
