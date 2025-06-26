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
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        int pendingCount = 0;

        if (state is OrdersLoaded) {
          pendingCount = state.orders
              .where((order) => order.clientStatus == ClientStatus.noConfirmado)
              .length;
        }

        return TabBar(
            controller: controller,
            unselectedLabelColor: Colors.black,
            indicatorColor: const Color(0xFFF44565),
            dividerColor: Colors.grey.shade400,
            labelColor: const Color(0xFFF44565),
            tabs: [
              const CustomTab(text: 'Agendados'),
              CustomTab(text: 'Por confirmar', number: pendingCount)
            ]);
      },
    );
  }
}
