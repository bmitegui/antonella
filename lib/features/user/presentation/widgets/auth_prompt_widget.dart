import 'package:antonella/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPromptWidget extends StatelessWidget {
  final bool isSignIn;
  const AuthPromptWidget({super.key, this.isSignIn = true});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '¿${isSignIn ? 'No' : 'Ya'} tienes una cuenta? ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                  text: isSignIn ? 'Regístrate' : 'Ingresa aquí',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: themeClass.lightPrimaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => GoRouter.of(context)
                        .go('/${isSignIn ? 'signUp' : 'signIn'}'))
            ]));
  }
}
