import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

class UploadUserPhotoWidget extends StatelessWidget {
  const UploadUserPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomModalBottomSheetWidget(
        title: texts.profile_picture,
        otherAction: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline)),
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CustomCircularIconButtom(
              onTap: () {},
              icon: Icon(Icons.photo_camera_outlined),
              bottomTitle: texts.camera),
          CustomCircularIconButtom(
              onTap: () {},
              icon: Icon(Icons.photo_outlined),
              bottomTitle: texts.galery)
        ]));
  }
}
