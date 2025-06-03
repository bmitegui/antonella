import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ListServicesModel extends ListServicesEntity {
  ListServicesModel({required super.services});

  factory ListServicesModel.fromJson(Map<String, dynamic> json) {
    List<ServiceEntity> services = [];

    if (json['services'] != null) {
      services = json['services'].map<ServiceModel>((serviceData) {
        return ServiceModel.fromJson(serviceData);
      }).toList();
    }

    return ListServicesModel(services: services);
  }
}
