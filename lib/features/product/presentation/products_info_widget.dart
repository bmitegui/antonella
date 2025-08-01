import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/product/presentation/products_by_subcategory_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsInfoWidget extends StatelessWidget {
  const ProductsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      return (state is ProductsLoaded)
          ? (state.listProducts.products.isNotEmpty)
              ? RefreshIndicator(
                  onRefresh: () async =>
                      context.read<ProductsBloc>().add(GetProductsEvent()),
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 100),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state
                              .getDataBySubCategories()
                              .entries
                              .map((entry) {
                            return ProductsBySubcategoryWidget(
                                subCategory: entry.key, products: entry.value);
                          }).toList())))
              : Center(
                  child: Text(texts.no_products_for_category))
          : (state is ProductsError)
              ? Center(
                  child: Text(mapFailureToMessage(
                      context: context, failure: state.failure)))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
