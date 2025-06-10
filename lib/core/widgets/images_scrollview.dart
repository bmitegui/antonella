import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesScrollview extends StatelessWidget {
  final List<String> imageLinks;
  final PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  ImagesScrollview({super.key, required this.imageLinks});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: PageView.builder(
              controller: controller,
              itemCount: imageLinks.length,
              itemBuilder: (_, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(48),
                        bottomRight: Radius.circular(48)),
                    child: CustomCachedNetworkImage(imageUrl: imageLinks[index]));
              })),
      const SizedBox(height: 8),
      SmoothPageIndicator(
          controller: controller,
          count: imageLinks.length,
          effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Color(0xff333333),
              dotColor: Colors.grey))
    ]);
  }
}
