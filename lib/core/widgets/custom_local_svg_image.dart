import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLocalSvgImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const CustomLocalSvgImage(
      {super.key,
      required this.assetPath,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetPath,
        // ignore: deprecated_member_use
        color: color,
        width: width,
        height: height,
        fit: fit,
        placeholderBuilder: (context) =>
            const Center(child: CircularProgressIndicator()));
  }
}
