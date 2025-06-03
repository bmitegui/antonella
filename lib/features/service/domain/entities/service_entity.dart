import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

enum ServiceCategory {all, makeup, hair, nails, spa}
class ServiceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final ServiceCategory category;
  final String subCategory;
  final String urlImage;
  final double minPrice;
  final double maxPrice;
  final bool isSelected;
  final List<ServiceFormEntity>? listServiceFormsEntity;

  const ServiceEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.subCategory,
      required this.urlImage,
      required this.minPrice,
      required this.maxPrice,
      required this.isSelected,
      this.listServiceFormsEntity});

  @override
  List<Object?> get props => [id];

  ServiceEntity copyWith({
    String? id,
    String? name,
    String? description,
    ServiceCategory? category,
    String? subCategory,
    String? urlImage,
    double? minPrice,
    double? maxPrice,
    bool? isSelected,
    List<ServiceFormEntity>? listServiceFormsEntity,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      urlImage: urlImage ?? this.urlImage,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      isSelected: isSelected ?? this.isSelected,
      listServiceFormsEntity:
          listServiceFormsEntity ?? this.listServiceFormsEntity,
    );
  }
}
