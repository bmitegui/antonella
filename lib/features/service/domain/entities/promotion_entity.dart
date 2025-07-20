import 'package:equatable/equatable.dart';

class PromotionEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imageUrl;
  final List<dynamic> serviceItems;
  final List<dynamic> productItems;

  const PromotionEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.serviceItems,
      required this.productItems
      });

  @override
  List<Object?> get props => [id];
}

