import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/widgets/services_type_group.dart';
import 'package:flutter/material.dart';

class InfoServicesChosen extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoServicesChosen({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final categories = orderEntity.appointments
        .map((appointment) => appointment.serviceEntity.type)
        .toSet()
        .toList();
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(children: [
          Row(children: [
            Text('Servicios escogidos: ${orderEntity.appointments.length}'),
            Spacer(),
            Text('Ver más',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFFF44565),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF44565)))
          ]),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: ServicestypeGroup(servicesType: categories)),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Text(orderEntity.appointments
                      .map((appoitment) => appoitment.serviceEntity.name)
                      .toList()
                      .join(', '))
                ]))
          ]),
          SizedBox(height: 8),
          Row(children: [
            SizedBox(width: 25),
            Icon(Icons.calendar_month),
            SizedBox(width: 20),
            Text(
                '${orderEntity.appointments[0].day} - ${orderEntity.appointments[0].startTime}')
          ]),
        ]));
  }
}
