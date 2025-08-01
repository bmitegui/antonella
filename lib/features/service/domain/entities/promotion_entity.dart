import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:equatable/equatable.dart';

enum ServiceItemType { descuento }

class ServiceItemEntity extends Equatable {
  final ServiceEntity serviceEntity;
  final ServiceItemType serviceItemType;
  final double? fixedAmount;
  final double? discount;

  const ServiceItemEntity(
      {required this.serviceEntity,
      required this.serviceItemType,
      required this.fixedAmount,
      required this.discount});

  @override
  List<Object?> get props => [serviceEntity.id];
}

class PromotionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final List<ServiceItemEntity> serviceItems;

  const PromotionEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.images,
      required this.serviceItems});

  @override
  List<Object?> get props => [id];
}
