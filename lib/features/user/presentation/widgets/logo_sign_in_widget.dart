import 'package:antonella/core/widgets/curva_superior.dart';
import 'package:flutter/material.dart';

class LogoSignInWidget extends StatelessWidget {
  const LogoSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      Positioned(
          top: MediaQuery.of(context).size.height*0.12,
          left: 0,
          right: 0,
          child: Image.asset('assets/icon/logo.png',
              height: MediaQuery.of(context).size.height / 7)),
      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      ClipPath(
          clipper: CurvaSuperior(),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              color: Color(0xFFE596A9))),
              
      //SizedBox(height: 16)
            ])
      
    ]);
  }
}
