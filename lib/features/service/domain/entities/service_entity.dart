import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String category;
  final String subCategory;
  final String urlImage;
  final double minPrice;
  final double maxPrice;
  final bool isSelected;

  const ServiceEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.subCategory,
      required this.urlImage,
      required this.minPrice,
      required this.maxPrice,
      required this.isSelected});

  @override
  List<Object?> get props => [id];
}
