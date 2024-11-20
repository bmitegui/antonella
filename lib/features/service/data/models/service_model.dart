import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required super.id,
      required super.name,
      required super.asset,
      required super.isSelected,
      required super.subServices});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    List<SubServiceEntity> subServices = [];

    if (json['subServices'] != null) {
      subServices =
          (json['subServices'] as List).map<SubServiceEntity>((subService) {
        return SubServiceModel.fromJson(Map<String, dynamic>.from(subService));
      }).toList();
    }

    return ServiceModel(
        id: json['id'],
        name: json['name'],
        isSelected: json['selected'],
        asset: json['asset'],
        subServices: subServices);
  }
}
