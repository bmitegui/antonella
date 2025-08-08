import 'dart:io';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/profile_user/profile_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

class UploadUserPhotoWidget extends StatelessWidget {
  const UploadUserPhotoWidget({super.key});

  final String defaultImagePath = 'assets/img/placeholder_women.png';

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final converted = await convertFileToBase64(file);
      if (converted != null) {
        final userState = sl<UserBloc>().state;
        if (userState is UserAuthenticated) {
          sl<ProfileUserBloc>().add(UpdateUserProfileEvent(
              userId: userState.user.id,
              base64Photo: converted,
              name: null,
              phoneNumber: null,
              gmail: null));
        }
      }
    }
  }

  // void _deletePhoto(BuildContext context) async {
  //   Navigator.pop(context);
  //   File file = File('assets/img/placeholder_women.png');
  //   final converted = await convertFileToBase64(file);
  //   if (converted != null) {
  //     final userState = sl<UserBloc>().state;
  //     if (userState is UserAuthenticated) {
  //       sl<ProfileUserBloc>().add(UpdateUserProfileEvent(
  //         userId: userState.user.id,
  //         base64Photo: converted,
  //         name: null,
  //         phoneNumber: null,
  //         gmail: null,
  //       ));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    //final userState = sl<UserBloc>().state;

    //bool showDeleteButton = false;
    // if (userState is UserAuthenticated) {
    //   showDeleteButton = userState.user.photoUrl != defaultImagePath;
    // }
    return CustomModalBottomSheetWidget(
        title: texts.profile_picture,
        // otherAction: showDeleteButton
        //   ? IconButton(
        //       onPressed: () => _deletePhoto(context),
        //       icon: const Icon(Icons.delete_outline),
        //     )
        //   : null,
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CustomCircularIconButtom(
              onTap: () => _pickImage(context, ImageSource.camera),
              icon: const Icon(Icons.photo_camera_outlined),
              bottomTitle: texts.camera),
          CustomCircularIconButtom(
              onTap: () => _pickImage(context, ImageSource.gallery),
              icon: const Icon(Icons.photo_outlined),
              bottomTitle: texts.galery)
        ]));
  }
}
