import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesScrollview extends StatelessWidget {
  final List<String> imageLinks;
  final PageController controller = PageController(viewportFraction: 0.8, keepPage: true);

  ImagesScrollview({super.key, required this.imageLinks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView.builder(
            controller: controller,
            itemCount: imageLinks.length,
            itemBuilder: (_, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageLinks[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: controller,
          count: imageLinks.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xff333333),
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}
