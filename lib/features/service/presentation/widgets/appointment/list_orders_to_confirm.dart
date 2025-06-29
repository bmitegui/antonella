import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOrdersToConfirm extends StatelessWidget {
  const ListOrdersToConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state is OrdersLoaded) {
        // Filtrar solo órdenes no confirmadas por el cliente
        final ordersToConfirm = state.orders
            .where((order) => order.clientStatus == ClientStatus.noConfirmado)
            .toList();

        return ordersToConfirm.isNotEmpty
            ? ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: ordersToConfirm.length,
                itemBuilder: (BuildContext context, int index) =>
                    InfoOrderContainer(
                  orderEntity: ordersToConfirm[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 16),
              )
            : Center(child: Text('No hay citas pendientes por confirmar'));
      } else if (state is OrdersError) {
        return Text(
          mapFailureToMessage(context: context, failure: state.failure),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
