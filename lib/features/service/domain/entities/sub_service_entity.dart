import 'package:antonella/features/professional/domain/entities/entities.dart';

class SubServiceEntity {
  final String id;
  final String name;
  final String category;
  final String urlImage;
  final List<ProfessionalEntity> proffesionals;

  SubServiceEntity(
      {required this.id,
      required this.name,
      required this.category,
      required this.urlImage,
      required this.proffesionals});
}
