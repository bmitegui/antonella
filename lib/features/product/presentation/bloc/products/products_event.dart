part of 'products_bloc.dart';

sealed class ProductsEvent {
  const ProductsEvent();
}

final class ProductsInitialEvent extends ProductsEvent {}

final class GetProductsEvent extends ProductsEvent {
  final ProductType? productType;
  GetProductsEvent({this.productType});
}