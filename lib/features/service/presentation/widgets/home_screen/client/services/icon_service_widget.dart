import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:flutter/material.dart';

class IconServiceWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCircularIconButtom(
        borderColor: isSelected ? colorScheme.primary : null,
        bottomTitleColor: isSelected ? colorScheme.primary : null,
        fontWeight: FontWeight.bold,
        bottomTitle: bottomTitle,
        padding: EdgeInsets.zero,
        icon: CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.onPrimary,
            child: CustomLocalSvgImage(assetPath: asset)),
        onTap: onTap);
  }
}
