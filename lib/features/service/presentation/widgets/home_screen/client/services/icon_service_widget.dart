import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_local_image.dart';
import 'package:flutter/material.dart';

class IconServiceWidget extends StatefulWidget {
  final String bottomTitle;
  final String asset;
  final bool isSelected;
  final Function() onTap;
  const IconServiceWidget(
      {super.key,
      required this.bottomTitle,
      required this.asset,
      required this.isSelected,
      required this.onTap});

  @override
  State<IconServiceWidget> createState() => _IconServiceWidgetState();
}

class _IconServiceWidgetState extends State<IconServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCircularIconButtom(
        borderColor: widget.isSelected ? colorScheme.primary : null,
        bottomTitleColor: widget.isSelected ? colorScheme.primary : null,
        fontWeight: FontWeight.bold,
        bottomTitle: widget.bottomTitle,
        padding: EdgeInsets.zero,
        icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.onPrimary
            ),
            child: CustomLocalImage(assetPath: widget.asset)),
        onTap: widget.onTap);
  }
}
