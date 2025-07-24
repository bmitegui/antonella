// import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
// import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
// import 'package:flutter/material.dart';

// class UploadUserPhotoWidget extends StatelessWidget {
//   const UploadUserPhotoWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomModalBottomSheetWidget(
//         title: 'Foto del perfil',
//         otherAction: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.delete_outline)),
//         body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           CustomCircularIconButtom(
//               onTap: () {},
//               icon: Icon(Icons.photo_camera_outlined),
//               bottomTitle: 'Cámara'),
//           CustomCircularIconButtom(
//               onTap: () {},
//               icon: Icon(Icons.photo_outlined),
//               bottomTitle: 'Galería')
//         ]));
//   }
// }

import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_circular_icon_buttom.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadUserPhotoWidget extends StatelessWidget {
  final String? initialPhotoUrl;
  const UploadUserPhotoWidget({super.key, this.initialPhotoUrl});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // Aquí deberías subir la imagen al backend o actualizar el estado del usuario
      print('Imagen seleccionada: ${file.path}');
      // Future<String?> img = convertFileToBase64(file);
      // print(Environment.apiUrl + file.path);

      // Por ejemplo, puedes emitir un evento al UserBloc para actualizar la foto:
      // context.read<UserBloc>().add(UpdateUserPhoto(file));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
      title: 'Foto del perfil',
      otherAction: IconButton(
        onPressed: () {
          // Aquí podrías emitir un evento para eliminar la foto
        },
        icon: const Icon(Icons.delete_outline),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomCircularIconButtom(
            onTap: () => _pickImage(context, ImageSource.camera),
            icon: const Icon(Icons.photo_camera_outlined),
            bottomTitle: 'Cámara',
          ),
          CustomCircularIconButtom(
            onTap: () => _pickImage(context, ImageSource.gallery),
            icon: const Icon(Icons.photo_outlined),
            bottomTitle: 'Galería',
          ),
        ],
      ),
    );
    // return CustomScaffold(
    //   backgroundColor: Colors.black,
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         if (initialPhotoUrl != null)
    //               Image.network(initialPhotoUrl!,
    //                   width: 250, height: 250, fit: BoxFit.cover),
    //         SizedBox(height: 16),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 CustomCircularIconButtom(
    //                   icon: const Icon(Icons.photo_camera_outlined),
    //                   onTap: () => _pickImage(context, ImageSource.camera),
    //                 ),
    //                 const Text("Cámara", style: TextStyle(color: Colors.white))
    //               ],
    //             ),
    //             Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 // IconButton(
    //                 //   iconSize: 64,
    //                 //   icon: const Icon(Icons.photo_outlined),
    //                 //   onPressed: () => _pickImage(context, ImageSource.gallery),
    //                 // ),
    //                 CustomCircularIconButtom(
    //                   icon: const Icon(Icons.photo_camera_outlined),
    //                   onTap: () => _pickImage(context, ImageSource.gallery),
    //                 ),
    //                 const Text("Galería", style: TextStyle(color: Colors.white))
    //               ],
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
