import 'package:flutter/material.dart';

class RetrocederLogoWidget extends StatelessWidget {
  const RetrocederLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvaLogo(),
      child: Icon(Icons.arrow_back),
    );
  }
}

class CurvaLogo extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width -150, size.height);
    path.lineTo(size.width - 150, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}