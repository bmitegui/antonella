import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/info_receipt.dart';
import 'package:antonella/features/service/presentation/widgets/info_services_chosen.dart';
import 'package:antonella/features/service/presentation/widgets/payment_method.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final OrderEntity orderEntity;
  const OrderScreen({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        leading: ArrowBack(),
        text: 'Cita Confirmada',
        paddingScroll: EdgeInsets.all(16),
        child: Column(children: [
          InfoServicesChosen(orderEntity: orderEntity),
          const SizedBox(height: 16),
          InfoReceipt(orderEntity: orderEntity),
          const SizedBox(height: 16),
          PaymentMethod(),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          FilledButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xFFF44565))),
              onPressed: () async => {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pagar ahora'),
                    Text('\$${getTotalBasePrice(orderEntity.appointments)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white))
                  ]))
        ]));
  }
}
