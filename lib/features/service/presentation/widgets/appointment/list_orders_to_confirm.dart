import 'package:antonella/features/service/presentation/bloc/orders/orders_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_order_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOrdersToConfirm extends StatefulWidget {
  const ListOrdersToConfirm({super.key});

  @override
  State<ListOrdersToConfirm> createState() => _ListOrdersToConfirmState();
}

class _ListOrdersToConfirmState extends State<ListOrdersToConfirm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state is OrdersLoaded) {
        return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: state.orders.length,
            itemBuilder: (BuildContext context, int index) =>
                InfoOrderContainer(orderEntity: state.orders[index]),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16));
      } else if (state is OrdersError) {
        return Text(state.message);
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
