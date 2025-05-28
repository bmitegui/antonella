import 'package:antonella/core/widgets/curva_superior.dart';
import 'package:flutter/material.dart';

class LogoSignInWidget extends StatelessWidget {
  const LogoSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight *0.35,
      child: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset('assets/icon/logo.png',
                height: screenHeight / 6)),
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ClipPath(
            clipper: CurvaSuperior(),
            child: Container(
                height: screenHeight * 0.35,
                color: Color(0xFFE596A9))),
                
              ])
        
      ]),
    );
  }
}
