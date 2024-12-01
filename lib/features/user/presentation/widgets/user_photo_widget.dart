import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/features/user/presentation/widgets/upload_user_photo_widget.dart';
import 'package:flutter/material.dart';

class UserPhotoWidget extends StatelessWidget {
  const UserPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: themeClass.lightTertiaryColor)),
          child: CircleAvatar(
              radius: 80.rh(context),
              backgroundColor: Colors.white,
              backgroundImage:
                  const AssetImage('assets/img/placeholder_women.png'))),
      Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
              onTap: () async => await showModalBottomSheet<List>(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (BuildContext context) {
                    return const UploadUserPhotoWidget();
                  }),
              child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6)
                  ]),
                  child: CircleAvatar(
                      radius: 24.rh(context),
                      backgroundColor: themeClass.lightTertiaryColor,
                      child: const Icon(Icons.add_a_photo_outlined,
                          color: Colors.white)))))
    ]);
  }
}
