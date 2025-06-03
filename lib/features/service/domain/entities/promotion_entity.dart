import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class PromotionEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<ServiceCategory> categories;

  const PromotionEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.categories});

  @override
  List<Object?> get props => [id];
}
