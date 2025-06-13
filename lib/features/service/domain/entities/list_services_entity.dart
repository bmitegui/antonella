import 'package:antonella/features/service/domain/entities/entities.dart';

class ListServicesEntity {
  final List<ServiceEntity> services;
  final Map<String, Set> types;
  ListServicesEntity({required this.services, required this.types});

  ListServicesEntity copyWith({
    List<ServiceEntity>? services,
    Map<String, Set>? types,
  }) {
    return ListServicesEntity(
      services: services ?? this.services,
      types: types ?? this.types,
    );
  }
}
