import 'package:antonella/features/service/domain/entities/entities.dart';

class ListServicesEntity {
  final List<ServiceEntity> services;
  final String categorySelected;

  ListServicesEntity({required this.services, required this.categorySelected});
}
