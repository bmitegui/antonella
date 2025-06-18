import 'package:antonella/core/widgets/custom_title.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/product_info_widget.dart';
import 'package:flutter/material.dart';

class ProductsBySubcategoryWidget extends StatelessWidget {
  final String subCategory;
  final List<ProductEntity> products;
  const ProductsBySubcategoryWidget({super.key, required this.subCategory, required this.products});
  


  @override
  Widget build(BuildContext context) {

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomTitle(title: subCategory),
      const SizedBox(height: 8),
      SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: products.map((product) {
          return ProductInfoWidget(productEntity: product);
        }).toList()))
      
    ]);
  }
}