import 'dart:io';
import 'package:antonella/core/theme/responsive_size.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:flutter/material.dart';

class ListPhotosWidget extends StatefulWidget {
  final List<File> listPhotos;
  const ListPhotosWidget({super.key, required this.listPhotos});

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
    return SizedBox(
        height: 300,
        child: Column(children: [
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Stack(children: [
                      Container(
                        padding: EdgeInsets.only(
                            right: (widget.listPhotos.length <= 1) ? 0 : 16),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: widget.listPhotos.isEmpty
                                ? Image.asset('assets/img/placeholder.jpg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity)
                                : FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: const AssetImage(
                                        'assets/img/placeholder.jpg'),
                                    image: AssetImage(
                                        widget.listPhotos[index].path),
                                    width: double.infinity,
                                    height: double.infinity)),
                      ),
                      if (widget.listPhotos.isNotEmpty)
                        Positioned(
                            left: 10,
                            bottom: 10,
                            child: IconButton(
                                iconSize: 40.rf(ctx),
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await showWarningDialog(
                                      context: context,
                                      title: 'Eliminar imagen',
                                      textOnAccept: 'Eliminar',
                                      message:
                                          '¿Está seguro que desea eliminar la imagen de la actividad?',
                                      onAccept: () async {});
                                }))
                    ]);
                  },
                  itemCount: widget.listPhotos.isNotEmpty
                      ? widget.listPhotos.length
                      : 1)),
          const SizedBox(height: 8),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(children: [
                Expanded(
                    child: CustomElevatedButton(
                        onPressed: () {}, child: const Text('Cámara'))),
                const SizedBox(width: 8),
                Expanded(
                    child: CustomElevatedButton(
                        onPressed: () {}, child: const Text('Galería')))
              ]))
        ]));
  }
}
