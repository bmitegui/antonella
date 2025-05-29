import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/widgets/curva_superior.dart';
import 'package:flutter/material.dart';

class LogoSignInWidget extends StatelessWidget {
  const LogoSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: screenHeight *0.4,
      child: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child:  Column(
              children: [
                Image.asset('assets/icon/logo.png',
                    height: screenHeight / 6),
                SizedBox(height: 16),
                Text(texts.welcome,
                                style: textTheme.bodyLarge!
                                    .copyWith(color: Color(0XFFF44565))),
              ],
            )),
        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ClipPath(
            clipper: CurvaSuperior(),
            child: Container(
                height: 200,
                color: Color(0xFFE596A9))),
                
              ])
        
      ]),
    );
  }
}
