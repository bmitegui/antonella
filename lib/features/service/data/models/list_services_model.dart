import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ListServicesModel extends ListServicesEntity {
  ListServicesModel({required super.services, required super.types});

  factory ListServicesModel.fromList(List lista) {
    List<ServiceEntity> services = [];
    Map<String, Set> types = {};

    if (lista.isNotEmpty) {
      services = lista.map<ServiceModel>((serviceData) {
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
