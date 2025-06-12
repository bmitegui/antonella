import 'dart:io';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ListPhotosWidget extends StatefulWidget {
  final ServiceFormEntity serviceFormEntity;
  const ListPhotosWidget({super.key, required this.serviceFormEntity});

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

    return BlocBuilder<ServiceFormBloc, ServiceFormState>(
        builder: (context, state) {
    final isEmpty = (state is ServiceFormLoaded)?(widget.serviceFormEntity.answer == null ||
                          widget.serviceFormEntity.answer.length == 0):false ;
      return (state is ServiceFormLoaded)
          ? Column(children: [
              ImagesScrollview(
                  height: 150,
                  isSVG: isEmpty,
                  isUrl: false,
                  images: isEmpty
                      ? ['assets/svg/upload_photo.svg']
                      : widget.serviceFormEntity.answer),
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
                      if (image != null) {
                        List<File>? listImages =
                            widget.serviceFormEntity.answer;
                        if (listImages != null) {
                          listImages.add(image);
                        } else {
                          listImages = [image];
                        }
                        sl<ServiceFormBloc>().add(UpdateAnswerEvent(
                            id: widget.serviceFormEntity.id,
                            answer: listImages,
                            listServiceForms: state.listServiceForms));
                      }
                    },
                    text: 'Cámara'),
                CustomElevatedButton(
                    onPressed: () async {
                      final image = await pickImage(ImageSource.gallery);
                      if (image != null) {
                        List<File>? listImages =
                            widget.serviceFormEntity.answer;
                        if (listImages != null) {
                          listImages.add(image);
                        } else {
                          listImages = [image];
                        }
                        sl<ServiceFormBloc>().add(UpdateAnswerEvent(
                            id: widget.serviceFormEntity.id,
                            answer: listImages,
                            listServiceForms: state.listServiceForms));
                      }
                    },
                    text: 'Galería')
              ])
            ])
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
