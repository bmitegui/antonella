import 'package:antonella/features/service/domain/entities/entities.dart';

class PromotionModel extends PromotionEntity {
  const PromotionModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.categoryServices,
      required super.categoryProducts
      });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'], 
      name: json['title'], 
      description: json['description'], 
      imageUrl: json['images'], 
      categoryServices: json['service_items'], 
      categoryProducts: json['product_items']
      );
  }
}
