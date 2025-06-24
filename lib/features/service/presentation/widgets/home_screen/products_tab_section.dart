import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/custom_search_widget.dart';
import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:antonella/features/product/presentation/products_info_widget.dart';
import 'package:flutter/material.dart';

class ProductsTabSection extends StatelessWidget {
  const ProductsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async => sl<ProductsBloc>().add(GetProductsEvent()),
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  CustomSearchWidget(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  ProductsInfoWidget()
                ]))));
  }
}
