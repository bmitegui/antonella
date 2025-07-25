import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.nombre,
      required super.type,
      required super.serviceType,
      required super.serviceSubtype,
      required super.volume,
      required super.description,
      required super.price,
      required super.stock,
      required super.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        nombre: capitalize(json['name']),
        type: stringToProductType(json['product_type']),
        serviceType: stringToType(json['service_type']),
        serviceSubtype: capitalize(json['service_subtype']),
        volume: json['volume'],
        description: capitalize(json['description']),
        price: json['price'],
        stock: json['stock'],
        images: List<String>.from(json['images']));
  }
}
