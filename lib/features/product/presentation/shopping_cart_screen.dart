import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/product/presentation/options_pay_shopping_cart_screen.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/presentation/bloc/orders/orders_bloc.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final Set<String> selectedProductIds = {};
  bool value = false;

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        leading: ArrowBack(),
        text: texts.shopping_cart,
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
                      child: Text(texts.pay))
                  : const SizedBox.shrink();
            })),
        body: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
          builder: (context, productState) {

            return BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, orderState) {
                return BlocBuilder<PromotionCartBloc, PromotionCartState>(
                  builder: (context, promotionState) {
                    if (productState is ProductsSelectedLoaded && orderState is OrdersLoaded && promotionState is PromotionCartLoaded) {
                      final orders = orderState.orders;
                      final promotions = promotionState.cartPromotions;
                      
                      final ordersConfirmed = orders.where((order) {
                        final isClientConfirmed =
                            order.clientStatus == ClientStatus.confirmado;
                            

                        return isClientConfirmed;
                      }).toList();

                      // final ordersConfirmed = orders.where((order) {
                      //   final isClientConfirmed = order.clientStatus == ClientStatus.noConfirmado;
                      //   final isRelatedToPromotion = serviceIdsFromPromotions.contains(order.id);
                      //   return isClientConfirmed && !isRelatedToPromotion;
                      // }).toList();
                      
                      if (selectedProductIds.isEmpty && productState.products.isNotEmpty) {
                        selectedProductIds.addAll(productState.products.map((p) => p.id));
                      }

                      final selectedProducts = productState.products
                          .where((p) => selectedProductIds.contains(p.id))
                          .toList();

                      final dataTotal = calculateTotals(selectedProducts); 

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(texts.products, style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Color(0xFFF44565))),
                                const SizedBox(height: 16),
                                Text('${productState.products.length} items'),
                                const SizedBox(height: 16),
                                Column(
                                    children: getUniqueProducts(productState.products)
                                        .map((product) => Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: buildCartItem(
                                                productEntity: product,
                                                quantity: countProductsById(
                                                    products: productState.products,
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
                                
                                // Servicios en el carrito de compras 
                                if (ordersConfirmed.isNotEmpty)
                                  Text(texts.services, style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Color(0xFFF44565))), 
                                  const SizedBox(height: 16),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) =>
                                        InfoOrderContainer(
                                      orderEntity: ordersConfirmed[index],
                                    ), 
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16), 
                                    itemCount: ordersConfirmed.length
                                  ),
                                const SizedBox(height: 16),
                                //Aqui Agregar builCartPromotion
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: promotions.isNotEmpty
                                    ? [
                                        Text(texts.promotions,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: const Color(0xFFF44565))),
                                        const SizedBox(height: 16),
                                        Column(
                                          children: promotions
                                              .map((promotion) => Padding(
                                                    padding: const EdgeInsets.only(bottom: 8),
                                                    child: buildCartPromotion(
                                                      promotionEntity: promotion,
                                                       value: value, 
                                                       onChanged: (bool? data) {
                                                        setState(() {
                                                          value = data!;
                                                        });
                                                      }),
                                                  ))
                                              .toList(),
                                        ),
                                      ]
                                    : [],
                                ),


                                // Elementos de subtotal, iva y total a pagar
                                const SizedBox(height: 16),
                                buildPriceRow(texts.subtotal, '\$${dataTotal['subtotal']}'),
                                const SizedBox(height: 8),
                                buildPriceRow(texts.iva, '\$${dataTotal['iva']}'),
                                const Divider(height: 32),
                                buildPriceRow(texts.total, '\$${dataTotal['total']}',
                                    isBold: true, fontSize: 18)
                              ])),
                      );
                      }
                      else if (productState is ProductsSelectedError) {
                        return Text(
                            mapFailureToMessage(context: context, failure: productState.failure));
                      } 
                      else if (orderState is OrdersError) {
                        return Text(
                            mapFailureToMessage(context: context, failure: orderState.failure));
                      }
                      else {
                        return CircularProgressIndicator();
                      }
                      }
                    );
                
              }
                  
            );         
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

  Widget buildCartPromotion({required PromotionEntity promotionEntity, required bool value, required onChanged}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Checkbox(value: value, onChanged: onChanged),
          Image.network(Environment.apiUrl + promotionEntity.imageUrl[0],
              width: 60, height: 60),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(promotionEntity.name,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ])),
        ],
      ),
    );

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
