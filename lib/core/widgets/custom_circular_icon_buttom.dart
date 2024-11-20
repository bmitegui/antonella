import 'package:flutter/material.dart';

class CustomCircularIconButtom extends StatelessWidget {
  final Widget icon;
  final String? bottomTitle;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Color? bottomTitleColor;
  final Function() onTap;
  final FontWeight? fontWeight;
  const CustomCircularIconButtom(
      {super.key,
      required this.icon,
      required this.onTap,
      this.bottomTitle,
      this.borderColor,
      this.padding = const EdgeInsets.all(16),
      this.bottomTitleColor,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    final effectiveborderColor = borderColor ?? Colors.grey.shade300;
    final effectivebottomTitleColor = bottomTitleColor ?? Colors.black54;

    return Column(children: [
      GestureDetector(
          onTap: onTap(),
          child: Container(
              clipBehavior: Clip.hardEdge,
              padding: padding,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: effectiveborderColor)),
              child: icon)),
      if (bottomTitle != null) const SizedBox(height: 4),
      if (bottomTitle != null)
        Text(bottomTitle!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: effectivebottomTitleColor, fontWeight: fontWeight))
    ]);
  }
}
