import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

class AuthPromptWidget extends StatelessWidget {
  final bool isSignIn;
  const AuthPromptWidget({super.key, this.isSignIn = true});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: '${isSignIn ? texts.dont_have_account : texts.have_account} ',
            style: textTheme.bodyMedium,
            children: [
              TextSpan(
                  text: isSignIn ? texts.sign_up : texts.sign_in,
                  style:
                      textTheme.bodyMedium!.copyWith(color: Color(0XFFF44565)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      sl<UserBloc>().add(ResetUserEvent());
                      GoRouter.of(context)
                          .go('/${isSignIn ? 'signUp' : 'signIn'}');
                    })
            ]));
  }
}
