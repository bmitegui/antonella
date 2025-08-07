import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/custom_tab.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgendaTabBar extends StatelessWidget {
  final TabController controller;

  const AgendaTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        int pendingCount = 0;
        int revisionCount = 0;

        if (state is OrdersLoaded) {
          pendingCount = state.orders
              .where((order) =>
                  order.clientStatus == ClientStatus.noConfirmado &&
                  order.orderStatus == OrderStatus.confirmado)
              .length;
          revisionCount = state.orders
              .where((order) =>
                  order.clientStatus == ClientStatus.noConfirmado &&
                  order.orderStatus == OrderStatus.noConfirmado)
              .length;
        }

        return TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: controller,
            unselectedLabelColor: Colors.black,
            indicatorColor: const Color(0xFFF44565),
            dividerColor: Colors.grey.shade400,
            labelColor: const Color(0xFFF44565),
            tabs: [
              CustomTab(text: texts.done),
              CustomTab(
                  text: texts.requieres_confirmation,
                  number: pendingCount == 0 ? null : pendingCount),
              CustomTab(
                  text: texts.pending,
                  number: revisionCount == 0 ? null : revisionCount)
            ]);
      },
    );
  }
}
