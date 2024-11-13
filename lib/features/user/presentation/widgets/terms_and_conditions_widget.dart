import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsWidget extends StatelessWidget {
  final bool isSignIn;
  const TermsAndConditionsWidget({super.key, this.isSignIn = true});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text:
                'Al ${isSignIn ? 'iniciar sesión' : 'registrarse'} correctamente, acepta nuestros ',
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(
                  text: 'Términos y Condiciones',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: themeClass.lightPrimaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: ' y nuestra ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: 'Política de Privacidad',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: themeClass.lightPrimaryColor),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: '.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black54))
            ]));
  }
}
