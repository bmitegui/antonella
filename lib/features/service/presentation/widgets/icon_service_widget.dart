import 'package:antonella/core/theme/app_theme.dart';
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
        borderColor: isSelected ? themeClass.lightPrimaryColor : null,
        bottomTitleColor: isSelected ? themeClass.lightPrimaryColor : null,
        fontWeight: isSelected ? FontWeight.bold : null,
        bottomTitle: bottomTitle,
        padding: const EdgeInsets.all(8),
        icon: CircleAvatar(
            radius: 16,
            foregroundImage: AssetImage(asset),
            backgroundColor: Colors.white),
        onTap: onTap);
  }
}
