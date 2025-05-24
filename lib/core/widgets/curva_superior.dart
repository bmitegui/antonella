import 'package:flutter/material.dart';

class CurvaSuperior extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0005917, size.height * -0.0005571);
    path_0.lineTo(size.width * 0.0014417, size.height * 0.9289571);
    path_0.quadraticBezierTo(size.width * 0.0334750, size.height * 0.9282571,
        size.width * 0.0833750, size.height * 0.9284571);
    path_0.cubicTo(
        size.width * 0.2939917,
        size.height * 0.9306714,
        size.width * 0.1679167,
        size.height * 0.4645857,
        size.width * 0.4995417,
        size.height * 0.4291571);
    path_0.cubicTo(
        size.width * 0.8207667,
        size.height * 0.4557714,
        size.width * 0.7051333,
        size.height * 0.9301857,
        size.width * 0.9155667,
        size.height * 0.9302000);
    path_0.quadraticBezierTo(size.width * 0.9572000, size.height * 0.9306571,
        size.width * 1.0005500, size.height * 0.9301571);
    path_0.lineTo(size.width * 0.9998917, size.height * -0.0017143);
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
