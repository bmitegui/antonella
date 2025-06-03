import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
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
    return CustomCircularIconButtom(
        borderColor: isSelected ? Color(0xFFF44565) : null,
        bottomTitleColor: isSelected ? Color(0xFFF44565) : null,
        fontWeight: isSelected ? FontWeight.bold : null,
        bottomTitle: bottomTitle,
        padding:  EdgeInsets.zero,
        icon: CircleAvatar(
            radius: 24,
            foregroundImage: AssetImage(asset),
            backgroundColor: Colors.white),
        onTap: onTap);
  }
}
