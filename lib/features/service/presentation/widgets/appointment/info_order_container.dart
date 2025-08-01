import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/core/widgets/banner_widget.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/order_screen.dart';
import 'package:flutter/material.dart';

class InfoOrderContainer extends StatefulWidget {
  final OrderEntity orderEntity;
  final bool hasCheckBox;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged;
  final bool canPay;
  const InfoOrderContainer(
      {super.key,
      required this.orderEntity,
      this.hasCheckBox = false,
      this.isSelected = false,
      this.onChanged,
      this.canPay = true});

  @override
  State<InfoOrderContainer> createState() => _InfoOrderContainerState();
}

class _InfoOrderContainerState extends State<InfoOrderContainer> {
  @override
  Widget build(BuildContext context) {
    final categories = widget.orderEntity.appointments
        .map((appointment) => appointment.serviceEntity.type)
        .toList();
    return GestureDetector(
        onTap: () => navigateWithSlideTransition(
            context,
            OrderScreen(
                orderEntity: widget.orderEntity, canPay: widget.canPay)),
        child: Container(
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.white),
                color: Colors.white),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                if (widget.hasCheckBox)
                  Checkbox(
                    value: widget.isSelected,
                    onChanged: widget.onChanged,
                  ),
                BannerWidget(
                    child: CustomLocalImage(
                        assetPath: imagesServiceCategory[ServiceType.all]!)),
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
                Text('\$${getTotalBasePrice(widget.orderEntity.appointments)}')
              ]),
              SizedBox(height: 8),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.calendar_month),
                SizedBox(width: 20),
                Text(
                    '${widget.orderEntity.appointments[0].day} - ${widget.orderEntity.appointments[0].startTime}')
              ]),
              Divider(),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.person),
                SizedBox(width: 20),
                Text(widget.orderEntity.userEntity.name)
              ]),
              SizedBox(height: 10),
              Row(children: [
                SizedBox(width: 25),
                Icon(Icons.email),
                SizedBox(width: 20),
                Text(widget.orderEntity.userEntity.email)
              ])
            ])));
  }
}
