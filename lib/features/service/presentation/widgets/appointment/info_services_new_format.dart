import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class InfoServicesNewFormat extends StatelessWidget {
  final bool canPay;
  final OrderEntity order;

  const InfoServicesNewFormat({super.key, required this.order,  this.canPay = true});

  @override
  Widget build(BuildContext context) {
    final appointments = order.appointments;
    final appointment = appointments.first;
    final user = order.userEntity;

    return GestureDetector(
      onTap: () => navigateWithSlideTransition(
          context, OrderScreen(orderEntity: order, canPay: canPay)),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
              ]),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                width: 10,
                height: 190,
                decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Servicios",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                        const SizedBox(height: 8),
                                        Row(
                                            children: appointments.map((a) {
                                          final imageUrl = a.serviceEntity
                                                  .images.isNotEmpty
                                              ? Environment.apiUrl +
                                                  a.serviceEntity.images.first
                                              : null;
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      Colors.pink.shade100,
                                                  backgroundImage: imageUrl !=
                                                          null
                                                      ? NetworkImage(imageUrl)
                                                      : null));
                                        }).toList())
                                      ]),
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Precio",
                                          style: bodyBlack54Style(context)),
                                      const SizedBox(height: 4),
                                      Text(
                                          '\$${_calculateTotalPrice(order).toStringAsFixed(2)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold))
                                    ]),
                                const SizedBox(width: 6),
                                const Icon(Icons.chevron_right,
                                    color: Colors.black54)
                              ]),
                          const SizedBox(height: 12),
                          Divider(color: Colors.grey.shade300, thickness: 1),
                          const SizedBox(height: 12),
                          Row(children: [
                            const Icon(Icons.person,
                                size: 16, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(user.name.isEmpty ? "Sin nombre" : user.name),
                            const Spacer(),
                            const Icon(Icons.calendar_month,
                                size: 16, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(appointment.day)
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            const Icon(Icons.email,
                                size: 16, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(user.email),
                            const Spacer(),
                            const Icon(Icons.access_time,
                                size: 16, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(appointment.startTime)
                          ])
                        ])))
          ])),
    );
  }

  double _calculateTotalPrice(OrderEntity order) {
    return order.appointments.fold(0.0, (sum, a) => sum + (a.basePrice ?? 0));
  }
}
