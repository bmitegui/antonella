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
      required super.rating,
      required super.minPrice,
      required super.maxPrice});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    final prices = (json['prices'] as List)
        .map((priceData) => PriceModel.fromJson(priceData))
        .toList();
    final questions = (json['questions'] as List)
        .map((questionData) => QuestionModel.fromJson(questionData))
        .toList();
    double minOfAll = prices.isNotEmpty
        ? prices
            .map((e) => e.minPrice)
            .fold<double>(prices.first.minPrice, (a, b) => a < b ? a : b)
        : 0.0;

    double maxOfAll = prices.isNotEmpty
        ? prices
            .map((e) => e.maxPrice)
            .fold<double>(prices.first.maxPrice, (a, b) => a > b ? a : b)
        : 0.0;

    return ServiceModel(
        id: json['id'],
        name: capitalize(json['name']),
        description: capitalize(json['description']),
        type: stringToType(json['type']),
        subtype: capitalize(json['subtype']),
        duration: json['duration'],
        prices: prices,
        images: List<String>.from(json['images']),
        questions: questions,
        rating: generarDoubleEntre35y50(),
        minPrice: minOfAll,
        maxPrice: maxOfAll);
  }
}
