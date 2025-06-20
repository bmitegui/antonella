import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/widgets/banner_widget.dart';
import 'package:antonella/features/service/presentation/widgets/order_screen.dart';
import 'package:flutter/material.dart';

class InfoOrderContainer extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoOrderContainer({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final categories = orderEntity.appointments
        .map((appointment) => appointment.serviceEntity.type)
        .toList();
    return GestureDetector(
        onTap: () => navigateWithSlideTransition(
            context, OrderScreen(orderEntity: orderEntity)),
        child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.white),
                color: Colors.white),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                BannerWidget(child: Icon(Icons.face)),
                const SizedBox(width: 16),
                Text(
                    getCategoryTextList(
                        context: context, serviceCategories: categories),
                    style: Theme.of(context).textTheme.titleMedium),
                Spacer(),
                Icon(Icons.arrow_forward_ios)
              ]),
              SizedBox(height: 16),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.attach_money),
                SizedBox(width: 20),
                Text('\$${getTotalBasePrice(orderEntity.appointments)}')
              ]),
              SizedBox(height: 8),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.calendar_month),
                SizedBox(width: 20),
                Text(
                    '${orderEntity.appointments[0].day} - ${orderEntity.appointments[0].startTime}')
              ]),
              Divider(),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.person),
                SizedBox(width: 20),
                Text(orderEntity.userEntity.name)
              ]),
              SizedBox(height: 10),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.email),
                SizedBox(width: 20),
                Text(orderEntity.userEntity.email)
              ])
            ])));
  }
}
