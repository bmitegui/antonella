import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:equatable/equatable.dart';

enum ProductType { all, shampoo, crema }

class ProductEntity extends Equatable {
  final String id;
  final String nombre;
  final ProductType type;
  final ServiceType serviceType;
  final String serviceSubtype;
  final int volume;
  final String description;
  final double price;
  final int stock;
  final List<String> images;

  const ProductEntity(
      {required this.id,
      required this.nombre,
      required this.type,
      required this.serviceType,
      required this.serviceSubtype,
      required this.volume,
      required this.description,
      required this.price,
      required this.stock,
      required this.images});

  @override
  List<Object?> get props => [id];
}
