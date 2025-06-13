import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesScrollview extends StatelessWidget {
  final List<dynamic> images;
  final bool isSVG;
  final bool isUrl;
  final double? height;
  final PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  ImagesScrollview(
      {super.key,
      required this.images,
      this.isSVG = false,
      this.height,
      this.isUrl = true});

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height / 2.5;
    final isEmpty = images.length < 2;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
          height: height ?? heightSize,
          child: PageView.builder(
              controller: controller,
              itemCount: images.length,
              itemBuilder: (_, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(48),
                        bottomRight: Radius.circular(48)),
                    child: isSVG
                        ? CustomLocalSvgImage(assetPath: images[index])
                        : isUrl
                            ? CustomCachedNetworkImage(
                                imageUrl: Environment.apiUrl + images[index])
                            : Image.file(images[index]));
              })),
      if (!isEmpty) const SizedBox(height: 8),
      if (!isEmpty)
        SmoothPageIndicator(
            controller: controller,
            count: images.length,
            effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Color(0xff333333),
                dotColor: Colors.grey))
    ]);
  }
}
