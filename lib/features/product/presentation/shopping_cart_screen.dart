import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/list_orders_to_confirm.dart';
import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomScaffold(
        leading: ArrowBack(),
        text: texts.shopping_cart,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Aquí puedes revisar las órdenes pendientes de pago", style: bodyBlack54Style(context)),
            ),
            Expanded(child: ListOrdersToConfirm()),
          ],
        ),
        // bottomNavigationBar: Container(
        //     padding: const EdgeInsets.all(16),
        //     child: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
        //         builder: (context, state) {
        //       return BlocBuilder<OrdersBloc, OrdersState>(
        //           builder: (context, orderState) {
        //         return FilledButton(
        //             onPressed: () {
        //               if (state is ProductsSelectedLoaded &&
        //                   orderState is OrdersLoaded) {
        //                 final productsSelected = state.products
        //                     .where((p) => selectedProductIds.contains(p.id))
        //                     .toList();

        //                 final servicesSelected = orderState.orders
        //                     .where((o) =>
        //                         o.clientStatus == ClientStatus.noConfirmado &&
        //                         o.orderStatus == OrderStatus.confirmado &&
        //                         selectedServiceIds.contains(o.id))
        //                     .toList();

        //                 navigateWithSlideTransition(
        //                   context,
        //                   OptionsPayShoppingCartScreen(
        //                       products: productsSelected,
        //                       services: servicesSelected,
        //                       total: dataTotal['total']!),
        //                 );
        //               }
        //             },
        //             child: Text(texts.pay));
        //       });
        //     })),
        // body: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
        //     builder: (context, productState) {
        //   return BlocBuilder<OrdersBloc, OrdersState>(
        //       builder: (context, orderState) {
        //     return BlocBuilder<PromotionCartBloc, PromotionCartState>(
        //         builder: (context, promotionState) {
        //       if (productState is ProductsSelectedLoaded &&
        //           orderState is OrdersLoaded &&
        //           promotionState is PromotionCartLoaded) {
        //         final ordersToConfirm = orderState.orders
        //             .where((order) =>
        //                 order.clientStatus == ClientStatus.noConfirmado &&
        //                 order.orderStatus == OrderStatus.confirmado)
        //             .toList();

        //         if (!initialized &&
        //             selectedProductIds.isEmpty &&
        //             selectedServiceIds.isEmpty) {
        //           selectedProductIds
        //               .addAll(productState.products.map((p) => p.id));
        //           selectedServiceIds.addAll(ordersToConfirm.map((o) => o.id));
        //           initialized = true;
        //         }

        //         final selectedProducts = productState.products
        //             .where((p) => selectedProductIds.contains(p.id))
        //             .toList();

        //         final selectedPromotions = promotionState.cartPromotions
        //             .where((p) => selectedPromotionIds.contains(p.id))
        //             .toList();

        //         final appointments = ordersToConfirm
        //             .where((o) => selectedServiceIds.contains(o.id))
        //             .expand((p) => p.appointments.map((ap) => ap))
        //             .toList();

        //         dataTotal = calculateTotals(
        //             selectedProducts: selectedProducts,
        //             selectedPromotions: selectedPromotions,
        //             appointments: appointments);

        //         return SingleChildScrollView(
        //             child: Padding(
        //                 padding: const EdgeInsets.all(16),
        //                 child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(texts.products,
        //                           style:
        //                               Theme.of(context).textTheme.titleMedium),
        //                       const SizedBox(height: 16),
        //                       Text('${productState.products.length} items'),
        //                       const SizedBox(height: 16),
        //                       Column(
        //                         children: getUniqueProducts(
        //                                 productState.products)
        //                             .map((product) => Padding(
        //                                 padding:
        //                                     const EdgeInsets.only(bottom: 8),
        //                                 child: buildCartItem(
        //                                     productEntity: product,
        //                                     quantity: countProductsById(
        //                                         products: productState.products,
        //                                         productId: product.id),
        //                                     isSelected: selectedProductIds
        //                                         .contains(product.id),
        //                                     onChanged: (bool? value) {
        //                                       setState(() {
        //                                         if (value == true) {
        //                                           selectedProductIds
        //                                               .add(product.id);
        //                                         } else {
        //                                           selectedProductIds
        //                                               .remove(product.id);
        //                                         }
        //                                       });
        //                                     })))
        //                             .toList(),
        //                       ),
        //                       if (ordersToConfirm.isNotEmpty) ...[
        //                         const SizedBox(height: 16),
        //                         Text(texts.services,
        //                             style: Theme.of(context)
        //                                 .textTheme
        //                                 .titleMedium),
        //                         const SizedBox(height: 16),
        //                         ListView.separated(
        //                           shrinkWrap: true,
        //                           physics: NeverScrollableScrollPhysics(),
        //                           itemCount: ordersToConfirm.length,
        //                           separatorBuilder: (_, __) =>
        //                               const SizedBox(height: 16),
        //                           itemBuilder: (context, index) {
        //                             final order = ordersToConfirm[index];
        //                             return Row(
        //                               children: [
        //                                 Checkbox(
        //                                   value: selectedServiceIds
        //                                       .contains(order.id),
        //                                   onChanged: (bool? value) {
        //                                     setState(() {
        //                                       if (value == true) {
        //                                         selectedServiceIds
        //                                             .add(order.id);
        //                                       } else {
        //                                         selectedServiceIds
        //                                             .remove(order.id);
        //                                       }
        //                                     });
        //                                   },
        //                                 ),
        //                                 Expanded(
        //                                     child: InfoServicesNewFormat(
        //                                         order: order, canPay: false)),
        //                               ],
        //                             );
        //                           },
        //                         )
        //                       ],
        //                       if (promotionState.cartPromotions.isNotEmpty) ...[
        //                         const SizedBox(height: 16),
        //                         Text(texts.promotions,
        //                             style: Theme.of(context)
        //                                 .textTheme
        //                                 .titleMedium),
        //                         const SizedBox(height: 16),
        //                         Column(
        //                             children: promotionState.cartPromotions
        //                                 .map((promotion) => Padding(
        //                                     padding: const EdgeInsets.only(
        //                                         bottom: 8),
        //                                     child: buildCartPromotion(
        //                                         promotionEntity: promotion,
        //                                         isSelected: selectedPromotionIds
        //                                             .contains(promotion.id),
        //                                         onChanged: (bool? selected) {
        //                                           setState(() {
        //                                             if (selected == true) {
        //                                               selectedPromotionIds
        //                                                   .add(promotion.id);
        //                                             } else {
        //                                               selectedPromotionIds
        //                                                   .remove(promotion.id);
        //                                             }
        //                                           });
        //                                         })))
        //                                 .toList())
        //                       ],
        //                       const SizedBox(height: 16),
        //                       buildPriceRow(texts.subtotal,
        //                           '\$${dataTotal['subtotal']?.toStringAsFixed(2)}'),
        //                       const SizedBox(height: 8),
        //                       buildPriceRow('Descuento',
        //                           '\$${dataTotal['discount']?.toStringAsFixed(2)}'),
        //                       const SizedBox(height: 8),
        //                       buildPriceRow(texts.iva,
        //                           '\$${dataTotal['iva']?.toStringAsFixed(2)}'),
        //                       const Divider(height: 32),
        //                       buildPriceRow(texts.total,
        //                           '\$${dataTotal['total']?.toStringAsFixed(2)}',
        //                           isBold: true)
        //                     ])));
        //       } else {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //     });
        //   });
        // })
        );
  }

  // Widget buildCartItem({
  //   required ProductEntity productEntity,
  //   required int quantity,
  //   required bool isSelected,
  //   required void Function(bool?) onChanged,
  // }) {
  //   return Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //           color: Colors.white, borderRadius: BorderRadius.circular(16)),
  //       child: Row(children: [
  //         Checkbox(value: isSelected, onChanged: onChanged),
  //         Image.network(Environment.apiUrl + productEntity.images.first,
  //             width: 60, height: 60),
  //         const SizedBox(width: 8),
  //         Expanded(
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //               Text(productEntity.nombre,
  //                   style: const TextStyle(fontWeight: FontWeight.w500)),
  //               const SizedBox(height: 4),
  //               Text('Cant $quantity')
  //             ])),
  //         Column(children: [
  //           QuantitySelectionWidget(
  //             productEntity: productEntity,
  //             quantity: quantity,
  //             onChanged: (value) {
  //               context.read<ProductsSelectedBloc>().add(
  //                     AddProductEvent(product: productEntity, cant: value),
  //                   );
  //             },
  //           ),
  //           const SizedBox(height: 40),
  //           Text('\$${productEntity.price}',
  //               style: const TextStyle(fontWeight: FontWeight.bold))
  //         ])
  //       ]));
  // }

  Widget buildCartPromotion({
    required PromotionEntity promotionEntity,
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
          SizedBox(
              width: 40,
              child: CustomCachedNetworkImage(
                  imageUrl: Environment.apiUrl + promotionEntity.images.first)),
          const SizedBox(width: 16),
          Expanded(child: Text(promotionEntity.title))
        ]));
  }

  Widget buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 14}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label,
          style: isBold
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.bodyMedium),
      Text(value,
          style: isBold
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.bodyMedium)
    ]);
  }

  Map<String, double> calculateTotals({
    required List<ProductEntity> selectedProducts,
    required List<AppointmentEntity> appointments,
  }) {
    double subtotal = 0.0;

    for (final product in selectedProducts) {
      subtotal += product.price;
    }

    for (final appointment in appointments) {
      subtotal += appointment.basePrice!;
    }

    final iva = (subtotal) * 0.12;
    final total = subtotal + iva;

    return {
      'subtotal': subtotal,
      'iva': iva,
      'total': total,
    };
  }
}
