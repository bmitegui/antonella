import 'package:antonella/features/product/domain/entities/product_entity.dart';

class ListProductsEntity {
  final List<ProductEntity> products;
  final Map<String, Set> types;
  ListProductsEntity({required this.products, required this.types});

  ListProductsEntity copyWith({
    List<ProductEntity>? products,
    Map<String, Set>? types,
  }) {
    return ListProductsEntity(
      products: products ?? this.products,
      types: types ?? this.types,
    );
  }
}