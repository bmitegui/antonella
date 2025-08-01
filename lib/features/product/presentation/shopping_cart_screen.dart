import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool initialized = false;
  final Set<String> selectedProductIds = {};
  final Set<String> selectedPromotionIds = {};

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
              return FilledButton(
                  onPressed: () {
                    // if (dataTotal[]) {
                    //   final selected = state.products
                    //       .where((p) => selectedProductIds.contains(p.id))
                    //       .toList();
                    //   navigateWithSlideTransition(context,
                    //       OptionsPayShoppingCartScreen(products: selected));
                    // }
                  },
                  child: Text(texts.pay));
            })),
        body: BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
            builder: (context, productState) {
          return BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, orderState) {
            return BlocBuilder<PromotionCartBloc, PromotionCartState>(
                builder: (context, promotionState) {
              if (productState is ProductsSelectedLoaded &&
                  orderState is OrdersLoaded &&
                  promotionState is PromotionCartLoaded) {
                final ordersToConfirm = orderState.orders
                    .where((order) =>
                        order.clientStatus == ClientStatus.noConfirmado && order.orderStatus == OrderStatus.confirmado)
                    .toList();

                if (!initialized &&
                    selectedProductIds.isEmpty &&
                    productState.products.isNotEmpty) {
                  selectedProductIds
                      .addAll(productState.products.map((p) => p.id));
                  initialized = true;
                }

                final selectedProducts = productState.products
                    .where((p) => selectedProductIds.contains(p.id))
                    .toList();

                final selectedPromotions = promotionState.cartPromotions
                    .where((p) => selectedPromotionIds.contains(p.id))
                    .toList();

                final appointments = ordersToConfirm
                    .expand((p) => p.appointments.map((ap) => ap))
                    .toList();

                final dataTotal = calculateTotals(
                    selectedProducts: selectedProducts,
                    selectedPromotions: selectedPromotions,
                    appointments: appointments);

                return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(texts.products,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: 16),
                              Text('${productState.products.length} items'),
                              const SizedBox(height: 16),
                              Column(
                                children: getUniqueProducts(
                                        productState.products)
                                    .map((product) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
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
                                                  selectedProductIds
                                                      .add(product.id);
                                                } else {
                                                  selectedProductIds
                                                      .remove(product.id);
                                                }
                                              });
                                            })))
                                    .toList(),
                              ),
                              if (ordersToConfirm.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(texts.services,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const SizedBox(height: 16),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: ordersToConfirm.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 16),
                                    itemBuilder: (context, index) =>
                                        InfoOrderContainer(
                                            orderEntity: ordersToConfirm[index],
                                            canPay: false))
                              ],
                              if (promotionState.cartPromotions.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(texts.promotions,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                const SizedBox(height: 16),
                                Column(
                                    children: promotionState.cartPromotions
                                        .map((promotion) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: buildCartPromotion(
                                                promotionEntity: promotion,
                                                isSelected: selectedPromotionIds
                                                    .contains(promotion.id),
                                                onChanged: (bool? selected) {
                                                  setState(() {
                                                    if (selected == true) {
                                                      selectedPromotionIds
                                                          .add(promotion.id);
                                                    } else {
                                                      selectedPromotionIds
                                                          .remove(promotion.id);
                                                    }
                                                  });
                                                })))
                                        .toList())
                              ],
                              const SizedBox(height: 16),
                              buildPriceRow(texts.subtotal,
                                  '\$${dataTotal['subtotal']?.toStringAsFixed(2)}'),
                              const SizedBox(height: 8),
                              buildPriceRow('Descuento',
                                  '\$${dataTotal['discount']?.toStringAsFixed(2)}'),
                              const SizedBox(height: 8),
                              buildPriceRow(texts.iva,
                                  '\$${dataTotal['iva']?.toStringAsFixed(2)}'),
                              const Divider(height: 32),
                              buildPriceRow(texts.total,
                                  '\$${dataTotal['total']?.toStringAsFixed(2)}',
                                  isBold: true)
                            ])));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            });
          });
        }));
  }

  Widget buildCartItem({
    required ProductEntity productEntity,
    required int quantity,
    required bool isSelected,
    required void Function(bool?) onChanged,
  }) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Checkbox(value: isSelected, onChanged: onChanged),
          Image.network(Environment.apiUrl + productEntity.images.first,
              width: 60, height: 60),
          const SizedBox(width: 8),
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
                      AddProductEvent(product: productEntity, cant: value),
                    );
              },
            ),
            const SizedBox(height: 40),
            Text('\$${productEntity.price}',
                style: const TextStyle(fontWeight: FontWeight.bold))
          ])
        ]));
  }

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
    required List<PromotionEntity> selectedPromotions,
    required List<AppointmentEntity> appointments,
  }) {
    double subtotal = 0.0;
    double discountTotal = 0.0;

    for (final product in selectedProducts) {
      subtotal += product.price;
    }

    for (final appointment in appointments) {
      subtotal += appointment.basePrice!;
    }

    for (final promo in selectedPromotions) {
      for (final item in promo.serviceItems) {
        if (item.serviceItemType == ServiceItemType.descuento) {
          final base = item.fixedAmount ?? 0.0;
          final percent = item.discount ?? 0.0;
          discountTotal += base + (item.serviceEntity.minPrice * percent);
        }
      }
    }

    final iva = (subtotal - discountTotal) * 0.12;
    final total = subtotal - discountTotal + iva;

    return {
      'subtotal': subtotal,
      'iva': iva,
      'total': total,
      'discount': discountTotal
    };
  }
}
