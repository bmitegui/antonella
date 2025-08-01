import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ServiceItemModel extends ServiceItemEntity {
  const ServiceItemModel(
      {required super.serviceEntity,
      required super.serviceItemType,
      required super.fixedAmount,
      required super.discount});
  factory ServiceItemModel.fromJson(
      Map<String, dynamic> json, ServiceEntity serviceEntity) {
    return ServiceItemModel(
        serviceEntity: serviceEntity,
        serviceItemType: stringToServiceItemType(json['type']),
        fixedAmount: json['fixed_amount'],
        discount: json['discount']);
  }
}

class PromotionModel extends PromotionEntity {
  const PromotionModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.images,
      required super.serviceItems});

  factory PromotionModel.fromJson(
      Map<String, dynamic> json, List<ServiceItemModel> serviceItems) {
    return PromotionModel(
        id: json['id'],
        title: capitalize(json['title']),
        description: capitalize(json['description']),
        images: List<String>.from(json['images']),
        serviceItems: serviceItems);
  }
}
