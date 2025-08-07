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

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final converted = await convertFileToBase64(file);
      if (converted != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    return CustomModalBottomSheetWidget(
        title: texts.profile_picture,
        otherAction: IconButton(
            onPressed: () {
              // Aquí podrías emitir un evento para eliminar la foto
            },
            icon: const Icon(Icons.delete_outline)),
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
