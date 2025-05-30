import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RetrocederLogoWidget extends StatelessWidget {
  final String route;
  const RetrocederLogoWidget({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvaLogo(),
      child: Container(
        width: 500,
        height: 200,
        color: const Color(0xFFF08DA2), // Color de fondo rosado
        child: Center(
          child: IconButton(
            onPressed: () => GoRouter.of(context).go(route),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30
            )
          )
        ),
      ),
    );
  }
  
}

class CurvaLogo extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0008333,size.height*0.0014286);
    path_0.lineTo(size.width*0.0004917,size.height*1.0003429);
    path_0.quadraticBezierTo(size.width*0.0509917,size.height*0.8783429,size.width*0.1386750,size.height*0.8666000);
    path_0.cubicTo(size.width*0.3412583,size.height*0.8507714,size.width*0.5630083,size.height*1.0972714,size.width*0.8395667,size.height*0.6423429);
    path_0.cubicTo(size.width*0.9626000,size.height*0.2874571,size.width*0.8091000,size.height*0.2021857,size.width*0.8116917,size.height*0.1599143);
    path_0.quadraticBezierTo(size.width*0.7969000,size.height*0.0733571,size.width*0.9986750,size.height*0.0005000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}