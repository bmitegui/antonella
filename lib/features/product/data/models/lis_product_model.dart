import 'package:antonella/features/product/data/models/product_model.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/list_products_entity.dart';

class ListProductsModel extends ListProductsEntity {
  ListProductsModel({required super.products, required super.types});

  factory ListProductsModel.fromJson(Map<String, dynamic> json) {
    List<ProductEntity> products = [];
    Map<String, Set> types = {};

    if (json['data'] != null && (json['data'] as List).isNotEmpty) {
      products = (json['data'] as List).map<ProductModel>((productData) {
        final type = productData['product_type'];
        final subtype = productData['service_subtype'];
        if (!types.containsKey(type)) {
          types[type] = {subtype};
        } else {
          (types[type] as Set).add(subtype);
        }
        return ProductModel.fromJson(productData);
      }).toList();
    }
    return ListProductsModel(products: products, types: types);
  }
}
