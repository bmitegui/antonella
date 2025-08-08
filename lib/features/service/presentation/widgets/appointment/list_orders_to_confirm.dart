import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/utils/error_messages_util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_services_new_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ListOrdersToConfirm extends StatelessWidget {
  const ListOrdersToConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state is OrdersLoaded) {
        // Filtrar solo órdenes no confirmadas por el cliente
        final ordersToConfirm = state.orders
            .where((order) =>
                order.clientStatus == ClientStatus.noConfirmado &&
                order.orderStatus == OrderStatus.confirmado)
            .toList();

        return ordersToConfirm.isNotEmpty
            ? ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: ordersToConfirm.length,
                itemBuilder: (BuildContext context, int index) =>
                    InfoServicesNewFormat(
                      
                  order: ordersToConfirm[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 16),
              )
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                LottieBuilder.asset("assets/lottie/calendar.json"),
                Text(texts.no_appointments_to_be_confirmed),
                const SizedBox(height: 128)
              ]);
      } else if (state is OrdersError) {
        return Text(
            mapFailureToMessage(context: context, failure: state.failure));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
