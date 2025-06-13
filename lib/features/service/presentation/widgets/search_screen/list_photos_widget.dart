import 'dart:convert';
import 'dart:io';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/service_form/service_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ListPhotosWidget extends StatefulWidget {
  final QuestionEntity question;
  const ListPhotosWidget({super.key, required this.question});

  @override
  State<ListPhotosWidget> createState() => _ListPhotosWidgetState();
}

class _ListPhotosWidgetState extends State<ListPhotosWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isEmpty = widget.question.answer == null ||
        (widget.question.answer as List).isEmpty;

    return Column(children: [
      ImagesScrollview(
          height: 150,
          isSVG: isEmpty,
          isUrl: false,
          images: isEmpty
              ? ['assets/svg/upload_photo.svg']
              : widget.question.answer),
      // if (widget.serviceFormEntity.answer != null)
      //   IconButton(
      //       icon: const Icon(Icons.delete,
      //           color: Colors.red),
      //       onPressed: () async {
      //         await showWarningDialog(
      //             context: context,
      //             title: 'Eliminar imagen',
      //             textOnAccept: 'Eliminar',
      //             message:
      //                 '¿Está seguro que desea eliminar la imagen?',
      //             onAccept: () async {
      //               List<File>? listImages =
      //                   widget.serviceFormEntity.answer;

      //               listImages!.removeAt(index);

      //               if (listImages.isEmpty) {
      //                 listImages = null;
      //               }
      //               sl<ServiceFormBloc>().add(
      //                   UpdateAnswerEvent(
      //                       id: widget
      //                           .serviceFormEntity.id,
      //                       answer: listImages,
      //                       listServiceForms:
      //                           state.listServiceForms));
      //             });
      //       }),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        CustomElevatedButton(
            onPressed: () async {
              final image = await pickImage(ImageSource.camera);
              final imageBase64 = await convertFileToBase64(image);
              if (imageBase64 != null) {
                List<String>? listImages = widget.question.answer;
                if (listImages != null) {
                  listImages.add(imageBase64.split('base64,').last);
                } else {
                  listImages = [imageBase64.split('base64,').last];
                }
                sl<ServiceFormBloc>().add(AnswerQuestionEvent(
                    questionId: widget.question.id, answer: listImages));
              }
            },
            text: 'Cámara'),
        CustomElevatedButton(
            onPressed: () async {
              final image = await pickImage(ImageSource.gallery);
              final imageBase64 = await convertFileToBase64(image);
              if (imageBase64 != null) {
                List<String>? listImages = widget.question.answer;
                if (listImages != null) {
                  listImages.add(imageBase64.split('base64,').last);
                } else {
                  listImages = [imageBase64.split('base64,').last];
                }
                sl<ServiceFormBloc>().add(AnswerQuestionEvent(
                    questionId: widget.question.id, answer: listImages));
              }
            },
            text: 'Galería')
      ])
    ]);
  }
}
