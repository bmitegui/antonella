import 'package:antonella/features/product/presentation/bloc/products/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsTabSection extends StatelessWidget {
  const ProductsTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      return (state is ProductsLoaded)
          ? Text(state.products[0].nombre)
          : (state is ProductsError)
              ? Text(state.message)
              : Center(child: CircularProgressIndicator());
    });
  }
}
