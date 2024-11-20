import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:flutter/material.dart';

class UploadUserPhotoWidget extends StatelessWidget {
  const UploadUserPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 48.rh(context),
              height: 4,
              decoration: BoxDecoration(
                  color: themeClass.lightEighthColor,
                  borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: themeClass.lightSeventhColor)),
            Text('Foto del perfil',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: themeClass.lightEighthColor,
                    fontWeight: FontWeight.bold)),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline,
                    color: themeClass.lightSeventhColor))
          ]),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            CustomCircularIconButtom(
                onTap: () {},
                icon: Icon(Icons.photo_camera_outlined,
                    color: themeClass.lightPrimaryColor),
                bottomTitle: 'Cámara'),
            CustomCircularIconButtom(
                onTap: () {},
                icon: Icon(Icons.photo_outlined,
                    color: themeClass.lightPrimaryColor),
                bottomTitle: 'Galería')
          ])
        ]));
  }
}
