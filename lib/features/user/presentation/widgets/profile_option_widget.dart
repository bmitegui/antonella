import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProfileOptionWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function() onTap;
  const ProfileOptionWidget(
      {super.key,
      required this.title,
      required this.iconData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        title: Row(children: [
          CustomIconButton(iconData: iconData),
          const SizedBox(width: 8),
          Expanded(
              child: Text(title,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)))
        ]),
        trailing:
            Icon(Icons.arrow_forward_ios, color: themeClass.lightEighthColor));
  }
}
