import 'dart:io';

import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoWidgetWithCameraGallery extends StatefulWidget {
  const PhotoWidgetWithCameraGallery({super.key});

  @override
  State<PhotoWidgetWithCameraGallery> createState() => _PhotoWidgetWithCameraGalleryState();
}

class _PhotoWidgetWithCameraGalleryState extends State<PhotoWidgetWithCameraGallery> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showImage(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_addImageCamera(), const SizedBox(width: 20), _addImageGallery()],
            )
          ],
        )
      ],
    );
  }

  Widget _addImageCamera() {
    final texts = AppLocalizations.of(context)!;
    return Column(
      children: [
        RawMaterialButton(
          fillColor: Theme.of(context).cardColor,
          child: const Icon(
            Icons.add_a_photo_outlined,
            color: Colors.white,
          ),
          elevation: 8,
          onPressed: () {
            getImage(false);
          },
          padding: const EdgeInsets.all(15),
          shape: const CircleBorder(),
        ),
        Text(texts.camera)
      ],
    );
  }

  Widget _addImageGallery() {
    final texts = AppLocalizations.of(context)!;
    return Column(
      children: [
        RawMaterialButton(
          fillColor: Theme.of(context).cardColor,
          child: const Icon(
            Icons.add_photo_alternate_rounded,
            color: Colors.white,
          ),
          elevation: 8,
          onPressed: () {
            getImage(true);
          },
          padding: const EdgeInsets.all(15),
          shape: const CircleBorder(),
        ),
        Text(texts.galery)
      ],
    );
  }

  Future<void> getImage(bool gallery) async {
    final texts = AppLocalizations.of(context)!;
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: gallery ? ImageSource.gallery : ImageSource.camera,
    );

    if (pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        
        compressQuality: 60,
        maxHeight: 500,
        maxWidth: 500,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.blue,
            toolbarTitle: texts.image_cut,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });
      }
    }
  }

  Widget _showImage() {
    if (_selectedImage != null) {
      return Column(
        children: [
          Image.file(_selectedImage!, width: 250, height: 250, fit: BoxFit.cover),
          const SizedBox(height: 10),
          RawMaterialButton(
            fillColor: Colors.red,
            child: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            elevation: 8,
            onPressed: () {
              setState(() {
                _selectedImage = null;
              });
            },
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
          ),
        ],
      );
    } else {
      return Image.asset('assets/placeholder.png', width: 250, height: 250);
    }
  }
}
