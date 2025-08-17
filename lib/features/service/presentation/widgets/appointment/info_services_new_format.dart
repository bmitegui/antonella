import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/client_row_info_to_employee.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';

class InfoServicesNewFormat extends StatelessWidget {
  final bool canPay;
  final OrderEntity order;

  const InfoServicesNewFormat(
      {super.key, required this.order, this.canPay = true});

  @override
  Widget build(BuildContext context) {
    final appointments = order.appointments;
    final appointment = appointments.first;
    final colorSqueme = Theme.of(context).colorScheme;

    return GestureDetector(
        onTap: () => navigateWithSlideTransition(
            context, OrderScreen(orderEntity: order, canPay: canPay)),
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(width: 8),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Servicios",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                            Row(
                                                children: appointments.map((a) {
                                              final imageUrl = a.serviceEntity
                                                      .images.isNotEmpty
                                                  ? Environment.apiUrl +
                                                      a.serviceEntity.images
                                                          .first
                                                  : null;
                                              return imageUrl != null
                                                  ? Container(
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                      width: 32,
                                                      child:
                                                          CustomCachedNetworkImage(
                                                              imageUrl:
                                                                  imageUrl))
                                                  : SizedBox.shrink();
                                            }).toList()),
                                            const SizedBox(height: 8),
                                            Text("Productos",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                            const SizedBox(height: 8),
                                            order.products.isNotEmpty
                                                ? Row(
                                                    children:
                                                        order.products.map((a) {
                                                    final imageUrl = a
                                                            .images.isNotEmpty
                                                        ? Environment.apiUrl +
                                                            a.images.first
                                                        : null;
                                                    return imageUrl != null
                                                        ? Container(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                            width: 48,
                                                            child:
                                                                CustomCachedNetworkImage(
                                                                    imageUrl:
                                                                        imageUrl))
                                                        : SizedBox.shrink();
                                                  }).toList())
                                                : Text(
                                                    'Esta orden no tiene productos',
                                                    style: bodyBlack54Style(
                                                        context)),
                                          ]),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("Precio",
                                              style: bodyBlack54Style(context)),
                                          const SizedBox(height: 4),
                                          Text(
                                              '\$${calculateTotals(order)['total']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold))
                                        ]),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.chevron_right,
                                        color: Colors.black54)
                                  ]),
                              const SizedBox(height: 8),
                              Divider(
                                  color: Colors.grey.shade300, thickness: 1),
                              const SizedBox(height: 8),
                              Row(children: [
                                Icon(Icons.calendar_month,
                                    size: 16, color: colorSqueme.secondary),
                                const SizedBox(width: 6),
                                Text(appointment.day),
                                Spacer(),
                                Icon(Icons.access_time_filled,
                                    size: 16, color: colorSqueme.secondary),
                                const SizedBox(width: 6),
                                Text(appointment.startTime)
                              ]),
                              ClientRowInfoToEmployee()
                            ])))
              ])),
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Text('\t\t')))
        ]));
  }
}
