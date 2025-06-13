import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/data/models/models.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class ServiceModel extends ServiceEntity {
  const ServiceModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.type,
      required super.subtype,
      required super.duration,
      required super.prices,
      required super.images,
      required super.questions,
      required super.rating});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final prices = (json['prices'] as List)
        .map((priceData) => PriceModel.fromJson(priceData))
        .toList();
    final questions = (json['questions'] as List)
        .map((questionData) => QuestionModel.fromJson(questionData))
        .toList();
    return ServiceModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        type: stringToType(json['type']),
        subtype: json['subtype'],
        duration: json['duration'],
        prices: prices,
        images: List<String>.from(json['images']),
        questions: questions,
        rating: generarDoubleEntre35y50());
  }
}

ServiceType stringToType(String type) {
  return type == 'SPA'
      ? ServiceType.spa
      : type == 'UÑAS'
          ? ServiceType.nails
          : type == 'CABELLO'
              ? ServiceType.hair
              : ServiceType.spa;
}
