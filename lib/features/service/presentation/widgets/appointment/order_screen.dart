import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_receipt.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_services_chosen.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/pay_order_button.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/payment_method.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  final OrderEntity orderEntity;
  const OrderScreen({super.key, required this.orderEntity});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _metodo = "EFECTIVO";

  @override
  Widget build(BuildContext context) {
    final clientConfirmed =
        widget.orderEntity.clientStatus == ClientStatus.confirmado;
    return CustomScaffold(
        leading: ArrowBack(),
        text: clientConfirmed ? 'Cita Confirmada' : 'Cita',
        paddingScroll: EdgeInsets.all(16),
        child: Column(children: [
          InfoServicesChosen(orderEntity: widget.orderEntity),
          if (!clientConfirmed)
            Column(children: [
              const SizedBox(height: 16),
              InfoReceipt(orderEntity: widget.orderEntity),
              const SizedBox(height: 16),
              PaymentMethod(
                  metodo: _metodo,
                  onChange: (value) => setState(() => _metodo = value)),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              PayOrderButton(metodo: _metodo, orderEntity: widget.orderEntity)
            ])
        ]));
  }
}
