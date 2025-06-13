import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ListServicesModel extends ListServicesEntity {
  ListServicesModel({required super.services, required super.types});

  factory ListServicesModel.fromJson(Map<String, dynamic> json) {
    List<ServiceEntity> services = [];
    Map<String, Set> types = {};

    if (json['data'] != null && (json['data'] as List).isNotEmpty) {
      services = (json['data'] as List).map<ServiceModel>((serviceData) {
        final type = serviceData['type'];
        final subtype = serviceData['subtype'];
        if (!types.containsKey(type)) {
          types[type] = {subtype};
        } else {
          (types[type] as Set).add(subtype);
        }
        return ServiceModel.fromJson(serviceData);
      }).toList();
    }
    return ListServicesModel(services: services, types: types);
  }
}
