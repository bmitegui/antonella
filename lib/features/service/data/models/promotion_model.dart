import 'package:antonella/features/service/domain/entities/entities.dart';

class PromotionModel extends PromotionEntity {
  const PromotionModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.imageUrl,
      required super.serviceItems,
      required super.productItems
      });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['id'], 
      name: json['title'], 
      description: json['description'], 
      imageUrl: List<String>.from(json['images']), 
      serviceItems: json['service_items'], 
      productItems: json['product_items']
      );
  }
}
