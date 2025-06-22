import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class InfoReceipt extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoReceipt({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(children: [
          Row(children: [
            Text('Datos de facturación'),
            Spacer(),
            Text('Cambiar',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Color(0xFFF44565),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFF44565)))
          ]),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 8),
          Row(children: [
            CustomLocalSvgImage(
                assetPath: 'assets/svg/factura.svg',
                height: 64,
                color: Color(0xFFF44565)),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(orderEntity.userEntity.name,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(orderEntity.userEntity.dni)
            ])
          ])
        ]));
  }
}
