import 'package:antonella/features/service/domain/entities/price_entity.dart';

class PriceModel extends PriceEntity {
  PriceModel(
      {required super.name, required super.minPrice, required super.maxPrice});

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
        name: json['name'],
        minPrice: json['min_price'],
        maxPrice: json['max_price']);
  }
}
