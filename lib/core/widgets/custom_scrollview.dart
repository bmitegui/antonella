import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomScrollviewImages extends StatefulWidget {
  const CustomScrollviewImages({super.key});

  @override
  State<CustomScrollviewImages> createState() => _CustomScrollviewState();
}

class _CustomScrollviewState extends State<CustomScrollviewImages> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  List<String> ListImages = [
    'assets/img/cabello.png',
    'assets/img/maquillaje.png',
    'assets/img/spa.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  itemCount: ListImages.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      child: SizedBox(
                        height: 280,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            ListImages[index],
                            fit: BoxFit.cover
                          ),
                        )
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SmoothPageIndicator(
                controller: controller,
                count: ListImages.length,
                effect: ExpandingDotsEffect()
              ),
            ],
          ),
        ),
      ),
    );
  }
}