import 'package:antonella/features/product/presentation/products_info_widget.dart';
import 'package:antonella/features/service/presentation/widgets/home_screen/custom_search_widget.dart';
import 'package:flutter/material.dart';

class ProductsTabSection extends StatelessWidget {
  const ProductsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomSearchWidget(),
            const SizedBox(height: 16),
            //ServicesFilterWidget(),
            const SizedBox(height: 16),
            ProductsInfoWidget()
          ]
        ),
      )
    );
  }
}
