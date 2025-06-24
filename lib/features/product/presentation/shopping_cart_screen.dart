import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
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
                  ? ElevatedButton(
                      onPressed: selectedProductIds.isNotEmpty
                        ? () {
                            final selected = state.products
                                .where((p) => selectedProductIds.contains(p.id))
                                .toList();

                            sl<CartBloc>().add(AddToCart(products: selected));
                            navigateWithSlideTransition(context, OptionsPayShoppingCartScreen());
                          }
                        : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF44565),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text('Pagar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))
                  : const SizedBox.shrink();
            })),
        body: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
            builder: (context, state) {
          if (state is ProductsSelectedLoaded) {

            final selectedProducts = selectedProductIds.isEmpty
              ? state.products
              : state.products
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
                                      imageUrl: Environment.apiUrl +
                                          product.images[0],
                                      title: product.nombre,
                                      stock: product.stock,
                                      price: '\$${product.price}',
                                      quantity: countProductsById(
                                          products: state.products,
                                          productId: product.id),
                                      onQuantityChanged: (newQuantity) {
                                        sl<ProductsSelectedBloc>().add(
                                          UpdateProductQuantityEvent(
                                            product: product,
                                            newQuantity: newQuantity,
                                          ),
                                        );
                                      },
                                      isSelected: selectedProductIds.contains(product.id),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value == true) {
                                            selectedProductIds.add(product.id);
                                          } else {
                                            selectedProductIds.remove(product.id);
                                          }
                                        });
                                        }
                                    )
                                  ))
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
            return Text(state.message);
          } else {
            return CircularProgressIndicator();
          }
        }));
  }

  Widget buildCartItem({
    required String imageUrl,
    required String title,
    required int stock,
    required String price,
    required int quantity,
    required void Function(int) onQuantityChanged,
    required bool isSelected,
    required void Function(bool?) onChanged,
  }) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Checkbox(value: isSelected, onChanged: onChanged),
          Image.network(imageUrl, width: 60, height: 60),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Cant $quantity')
              ])),
          Column(children: [
            QuantitySelectionWidget(
              stock: stock, 
              initialQuantity: quantity,
              onQuantityChanged: onQuantityChanged
            ),
            SizedBox(height: 40),
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold))
          ])
        ]));
  }

  Widget buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 14}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          )),
      Text(value,
          style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize))
    ]);
  }
}
