import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_services_new_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ListOrdersNotConfirmed extends StatelessWidget {
  const ListOrdersNotConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state is OrdersLoaded) {
        // Filtrar órdenes no confirmadas por cliente NI por admin
        final unconfirmedOrders = state.orders.where((order) {
          return order.clientStatus == ClientStatus.noConfirmado &&
              order.orderStatus == OrderStatus.noConfirmado;
        }).toList();

        return unconfirmedOrders.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.only(
                    right: 16, left: 16, top: 8, bottom: 100),
                itemCount: unconfirmedOrders.length,
                itemBuilder: (BuildContext context, int index) =>
                    InfoServicesNewFormat(
                        order: unconfirmedOrders[index], canPay: false),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 16),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("assets/lottie/calendar.json"),
                  Text("Sin órdenes pendientes"),
                  const SizedBox(height: 128)
                ],
              );
      } else if (state is OrdersError) {
        return Text(
            mapFailureToMessage(context: context, failure: state.failure));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
