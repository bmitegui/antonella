import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class UploadUserPhotoWidget extends StatelessWidget {
  const UploadUserPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
        title: 'Foto del perfil',
        otherAction: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline,
                color: themeClass.lightSeventhColor)),
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
        ]));
  }
}
