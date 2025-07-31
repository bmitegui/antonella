import 'package:flutter/material.dart';

class CustomLocalImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const CustomLocalImage(
      {super.key,
      required this.assetPath,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath,
        color: color,
        width: width,
        height: 75,
        fit: fit,
        frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) => child
    );        
  }
}
