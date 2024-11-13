import 'package:antonella/features/service/domain/entities/sub_service_entity.dart';

class ServiceEntity {
  final String id;
  final String name;
  final List<SubServiceEntity> subServices;

  ServiceEntity(
      {required this.id, required this.name, required this.subServices});
}
