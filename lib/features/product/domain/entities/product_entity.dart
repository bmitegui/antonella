import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:equatable/equatable.dart';

enum ProductType { all, cream, shampoo }

class ProductEntity extends Equatable{
  final String id;
  final String name;
  final String description;
  final ServiceType serviceType;
  final ProductType productType;
  final String serviceSubType;
  final int volume;
  final double price;
  final int stock;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.serviceType,
    required this.serviceSubType,
    required this.productType,
    required this.volume,
    required this.price,
    required this.stock,
    required this.images
    });

  @override
  List<Object?> get props => [id];

  ProductEntity copyWith(
    {
      String? id,
      String? name,
      String? description,
      ServiceType? serviceType,
      ProductType? productType,
      String? serviceSubType,
      int? volume,
      double? price,
      int? stock,
      List<String>? images
    }
  ) {
    return ProductEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      serviceType: serviceType ?? this.serviceType, 
      serviceSubType: serviceSubType ?? this.serviceSubType, 
      productType: productType ?? this.productType, 
      volume: volume ?? this.volume, 
      price: price ?? this.price, 
      stock: stock ?? this.stock, 
      images: images ?? this.images
      );
  }

}