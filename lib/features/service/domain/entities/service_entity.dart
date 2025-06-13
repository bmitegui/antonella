import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

enum ServiceType { all, makeup, hair, nails, spa }

class ServiceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final ServiceType type;
  final String subtype;
  final String duration;
  final List<PriceEntity> prices;
  final List<String> images;
  final List<QuestionEntity> questions;
  final double rating;

  const ServiceEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      required this.subtype,
      required this.duration,
      required this.prices,
      required this.images,
      required this.questions,
      required this.rating});

  @override
  List<Object?> get props => [id];

  ServiceEntity copyWith({
    String? id,
    String? name,
    String? description,
    ServiceType? type,
    String? subtype,
    String? duration,
    List<PriceEntity>? prices,
    List<String>? images,
    List<QuestionEntity>? questions,
    double? rating,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      duration: duration ?? this.duration,
      prices: prices ?? this.prices,
      images: images ?? this.images,
      questions: questions ?? this.questions,
      rating: rating ?? this.rating,
    );
  }
}
