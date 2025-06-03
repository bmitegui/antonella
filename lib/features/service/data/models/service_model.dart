import 'package:antonella/features/service/domain/entities/entities.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.category,
      required super.subCategory,
      required super.urlImage,
      required super.minPrice,
      required super.maxPrice,
      required super.isSelected});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        category: stringToServiceCategory(json['category']),
        subCategory: json['subCategory'] ?? '',
        urlImage: json['urlImage'] ?? '',
        minPrice: json['minPrice'] ?? 0.0,
        maxPrice: json['maxPrice'] ?? 0.0,
        isSelected: false);
  }
}

String serviceCategoryToString(ServiceCategory serviceCategory) {
  return serviceCategory.name;
}

ServiceCategory stringToServiceCategory(String serviceCategory) {
  return serviceCategory == 'spa'
      ? ServiceCategory.spa
      : serviceCategory == 'nails'
          ? ServiceCategory.nails
          : serviceCategory == 'hair'
              ? ServiceCategory.hair
              : ServiceCategory.spa;
}
