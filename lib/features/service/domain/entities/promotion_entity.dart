import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

class PromotionEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrl;
  final List<ServiceType> categoryServices;
  final List<ProductType> categoryProducts;

  const PromotionEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.categoryServices,
      required this.categoryProducts
      });

  @override
  List<Object?> get props => [id];
}
