import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceImageNetwork extends StatelessWidget {
  final String urlImage;
  final double? width;
  final double? height;
  const ServiceImageNetwork(
      {super.key, required this.urlImage, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            clipBehavior: Clip.hardEdge,
            width: width ?? MediaQuery.of(context).size.width / 2.2,
            height: height ?? MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: CustomCachedNetworkImage(imageUrl: urlImage)));
  }
}
