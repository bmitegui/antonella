import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/product/presentation/options_pay_shopping_cart_screen.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final Set<String> selectedProductIds = {};

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        leading: ArrowBack(),
        text: "Carrito de compras",
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
                builder: (context, state) {
              return (state is ProductsSelectedLoaded)
                  ? FilledButton(
                      onPressed: () {
                        if (selectedProductIds.isNotEmpty) {
                          final selected = state.products
                              .where((p) => selectedProductIds.contains(p.id))
                              .toList();

                          navigateWithSlideTransition(context,
                              OptionsPayShoppingCartScreen(products: selected));
                        }
                      },
                      child: Text('Pagar'))
                  : const SizedBox.shrink();
            })),
        body: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
            builder: (context, state) {
          if (state is ProductsSelectedLoaded) {
            // final selectedProducts = selectedProductIds.isEmpty
            //     ? state.products
            //     : state.products
            //         .where((p) => selectedProductIds.contains(p.id))
            //         .toList();

            // final dataTotal = calculateTotals(selectedProducts);

            if (selectedProductIds.isEmpty && state.products.isNotEmpty) {
              selectedProductIds.addAll(state.products.map((p) => p.id));
            }

            final selectedProducts = state.products
                .where((p) => selectedProductIds.contains(p.id))
                .toList();

            final dataTotal = calculateTotals(selectedProducts);

            return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${state.products.length} items'),
                      const SizedBox(height: 16),
                      Column(
                          children: getUniqueProducts(state.products)
                              .map((product) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: buildCartItem(
                                      productEntity: product,
                                      quantity: countProductsById(
                                          products: state.products,
                                          productId: product.id),
                                      isSelected: selectedProductIds
                                          .contains(product.id),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedProductIds.add(product.id);
                                          } else {
                                            selectedProductIds
                                                .remove(product.id);
                                          }
                                        });
                                      })))
                              .toList()),
                      const SizedBox(height: 16),
                      buildPriceRow('Subtotal', '\$${dataTotal['subtotal']}'),
                      const SizedBox(height: 8),
                      buildPriceRow('IVA', '\$${dataTotal['iva']}'),
                      const Divider(height: 32),
                      buildPriceRow('Total', '\$${dataTotal['total']}',
                          isBold: true, fontSize: 18)
                    ]));
          } else if (state is ProductsSelectedError) {
            return Text(
                mapFailureToMessage(context: context, failure: state.failure));
          } else {
            return CircularProgressIndicator();
          }
        }));
  }

  Widget buildCartItem({
    required ProductEntity productEntity,
    required int quantity,
    required bool isSelected,
    required void Function(bool?) onChanged,
  }) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          Checkbox(value: isSelected, onChanged: onChanged),
          Image.network(Environment.apiUrl + productEntity.images[0],
              width: 60, height: 60),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(productEntity.nombre,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Cant $quantity')
              ])),
          Column(children: [
            QuantitySelectionWidget(
                productEntity: productEntity,
                quantity: quantity,
                onChanged: (value) {
                  context.read<ProductsSelectedBloc>().add(
                      AddProductEvent(product: productEntity, cant: value));
                }),
            SizedBox(height: 40),
            Text('\$${productEntity.price}',
                style: const TextStyle(fontWeight: FontWeight.bold))
          ])
        ]));
  }

  Widget buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 14}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize)),
      Text(value,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize))
    ]);
  }
}
