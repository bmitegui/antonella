import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  final List<String> image;
  const DetailProductScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingScroll: EdgeInsets.all(0),
      leading: ArrowBack(),
      text: 'Detalles',
      extendBodyBehindAppBar: true,
      child: Column(
        children: [
          ImagesScrollview(images: image),
          
        ],
      ),
    );
  }
}