import 'package:antonella/features/professional/domain/entities/professional_entity.dart';

class SubServiceEntity {
  final String id;
  final String name;
  final List<ProfessionalEntity> proffesionals;

  SubServiceEntity(
      {required this.id, required this.name, required this.proffesionals});
}
