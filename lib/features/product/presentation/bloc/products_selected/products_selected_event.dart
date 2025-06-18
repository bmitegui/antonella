part of 'products_selected_bloc.dart';

sealed class ProductsSelectedEvent {
  const ProductsSelectedEvent();
}

final class ServicesSelectedInitialEvent extends ProductsSelectedEvent {}

final class AddProductEvent extends ProductsSelectedEvent {
  final ProductEntity product;
  AddProductEvent({required this.product});
}

final class DeleteProductEvent extends ProductsSelectedEvent {
  final ProductEntity product;
  DeleteProductEvent({required this.product});
}

final class ClearProductSelectedEvent extends ProductsSelectedEvent {}