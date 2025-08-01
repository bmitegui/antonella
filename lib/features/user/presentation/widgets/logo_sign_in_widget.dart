import 'package:flutter/material.dart';

class LogoSignInWidget extends StatelessWidget {
  const LogoSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Image.asset('assets/icon/logo.png',
          height: MediaQuery.of(context).size.height / 16));
        // Stack(children: [
        //   Positioned(
        //       top: MediaQuery.of(context).size.height * 0.13,
        //       left: 0,
        //       right: 0,
        //       child: Image.asset('assets/icon/logo.png',
        //           height: MediaQuery.of(context).size.height / 7)),
        //   ClipPath(
        //       clipper: CurvaSuperior(),
        //       child: Container(
        //           height: MediaQuery.of(context).size.height * 0.25,
        //           color: Color(0xFFE596A9)))
        // ]));
  }
}
