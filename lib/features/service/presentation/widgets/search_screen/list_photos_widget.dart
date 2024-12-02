import 'dart:io';

import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
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
      return (state is ServiceFormLoaded)
          ? SizedBox(
              height: 300,
              child: Column(children: [
                Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          final isEmpty =
                              widget.serviceFormEntity.answer == null ||
                                  widget.serviceFormEntity.answer.length == 0;
                          return Stack(children: [
                            Container(
                                padding: EdgeInsets.only(
                                    right: (widget.serviceFormEntity.answer ==
                                                null ||
                                            widget.serviceFormEntity.answer
                                                    .length <=
                                                1)
                                        ? 0
                                        : 16),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: isEmpty
                                        ? Image.asset(
                                            'assets/img/placeholder.jpg',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity)
                                        : FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(
                                                'assets/img/placeholder.jpg'),
                                            image: FileImage(widget
                                                .serviceFormEntity
                                                .answer[index]),
                                            width: double.infinity,
                                            height: double.infinity))),
                            if (widget.serviceFormEntity.answer != null)
                              Positioned(
                                  left: 10,
                                  bottom: 10,
                                  child: IconButton(
                                      iconSize: 40.rf(ctx),
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () async {
                                        await showWarningDialog(
                                            context: context,
                                            title: 'Eliminar imagen',
                                            textOnAccept: 'Eliminar',
                                            message:
                                                '¿Está seguro que desea eliminar la imagen?',
                                            onAccept: () async {
                                              List<File>? listImages = widget
                                                  .serviceFormEntity.answer;

                                              listImages!.removeAt(index);

                                              if (listImages.isEmpty) {
                                                listImages = null;
                                              }
                                              sl<ServiceFormBloc>().add(
                                                  UpdateAnswerEvent(
                                                      id: widget
                                                          .serviceFormEntity.id,
                                                      answer: listImages,
                                                      listServiceForms: state
                                                          .listServiceForms));
                                            });
                                      }))
                          ]);
                        },
                        itemCount: widget.serviceFormEntity.answer != null
                            ? widget.serviceFormEntity.answer.length
                            : 1)),
                const SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(children: [
                      Expanded(
                          child: CustomElevatedButton(
                              onPressed: () async {
                                final image =
                                    await pickImage(ImageSource.camera);
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
                                      listServiceForms:
                                          state.listServiceForms));
                                }
                              },
                              child: const Text('Cámara'))),
                      const SizedBox(width: 8),
                      Expanded(
                          child: CustomElevatedButton(
                              onPressed: () async {
                                final image =
                                    await pickImage(ImageSource.gallery);
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
                                      listServiceForms:
                                          state.listServiceForms));
                                }
                              },
                              child: const Text('Galería')))
                    ]))
              ]))
          : (state is ServiceFormError)
              ? Center(child: Text(state.message))
              : const Center(child: CircularProgressIndicator());
    });
  }
}
