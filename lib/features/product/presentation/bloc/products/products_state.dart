part of 'products_bloc.dart';

sealed class ProductsState {
  const ProductsState();
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final ListProductsEntity listProducts;
  final ProductType productType;
  ProductsLoaded({required this.listProducts, this.productType = ProductType.all});

  Map<String, List<ProductEntity>> getDataBySubCategories() {
    Map<String, List<ProductEntity>> data = {};
    for (var p in listProducts.products) {
      if (!data.containsKey(p.serviceSubtype)) {
        data[p.serviceSubtype] = [p];
      } else {
        data[p.serviceSubtype]!.add(p);
      }
    }
    return data;
  }
}

final class ProductsError extends ProductsState {
  final Failure failure;
  ProductsError({required this.failure});
}
