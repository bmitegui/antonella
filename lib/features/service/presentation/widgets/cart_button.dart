import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  bool showIconCart(BuildContext context) {
    final stateProduct = sl<ProductsSelectedBloc>().state;
    final productsEmpty = stateProduct is ProductsSelectedLoaded &&
        stateProduct.products.isNotEmpty;

    final stateOrder = sl<OrdersBloc>().state;
    final ordersToConfirmEmpty = stateOrder is OrdersLoaded &&
        stateOrder.orders
            .any((order) => order.clientStatus == ClientStatus.noConfirmado);
    return productsEmpty || ordersToConfirmEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return (showIconCart(context))
        ? FilledButton.icon(
            onPressed: () =>
                navigateWithSlideTransition(context, ShoppingCartScreen()),
            label: Icon(Icons.shopping_cart, color: colorScheme.onPrimary),
          )
        : const SizedBox.shrink();
  }
}
