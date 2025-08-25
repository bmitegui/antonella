import 'package:antonella/features/professional/domain/entities/entities.dart';

class ProfesionalModel extends ProfessionalEntity {
  ProfesionalModel({required super.id, required super.name});

  factory ProfesionalModel.fromJson(Map<String, dynamic> json) {
    return ProfesionalModel(id: json['id'], name: json['name']);
  }
}
