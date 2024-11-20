import 'package:antonella/features/professional/data/models/models.dart';
import 'package:antonella/features/professional/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class SubServiceModel extends SubServiceEntity {
  SubServiceModel(
      {required super.id,
      required super.name,
      required super.category,
      required super.urlImage,
      required super.proffesionals});

  factory SubServiceModel.fromJson(Map<String, dynamic> json) {
    List<ProfessionalEntity> proffesionals = [];

    if (json['proffesionals'] != null) {
      proffesionals = (json['proffesionals'] as List)
          .map<ProfessionalEntity>((poffesional) {
        return ProfesionalModel.fromJson(
            Map<String, dynamic>.from(poffesional));
      }).toList();
    }

    return SubServiceModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        urlImage: json['urlImage'],
        proffesionals: proffesionals);
  }
}
