part of 'products_bloc.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;
  ProductsLoaded({required this.products});
}

final class ProductsError extends ProductsState {
  final String message;
  ProductsError({required this.message});
}
