import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final Widget child;
  const BannerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipPath(
            clipper: BannerClipper(),
            child: Container(
                width: 70,
                height: 80,
                color: Color(0xFFF44565),
                child: Center(
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: child)))));
  }
}

class BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - 10);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
