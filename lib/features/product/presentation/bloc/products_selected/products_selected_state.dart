part of 'products_selected_bloc.dart';

sealed class ProductsSelectedState {
  const ProductsSelectedState();
}

final class ProductsSelectedLoading extends ProductsSelectedState {}

final class ProductsSelectedLoaded extends ProductsSelectedState {
  final List<ProductEntity> products;
  ProductsSelectedLoaded(
      {required this.products});
  ProductsSelectedLoaded copyWith({
    List<ProductEntity>? products,
  }) {
    return ProductsSelectedLoaded(
      products: products ?? this.products
    );
  }
}

final class ProductsSelectedError extends ProductsSelectedState {
  final String message;
  ProductsSelectedError({required this.message});
}
