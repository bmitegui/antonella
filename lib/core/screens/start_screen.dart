// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: const Color(0Xff890032),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(height: 64),
              Image.asset('assets/icon/logo_start_screen.png',
                  height: MediaQuery.of(context).size.height / 3),
              const SizedBox(height: 64),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(texts.start_title,
                                    textAlign: TextAlign.center,
                                    style: textTheme.bodyLarge!
                                        .copyWith(color: colorScheme.primary)),
                                const SizedBox(height: 16),
                                Text(texts.start_body,
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 64),
                                SizedBox(
                                    width: double.infinity,
                                    child: FilledButton(
                                        onPressed: () async => await _seen(),
                                        child: Text(texts.start)))
                              ]))))
            ])));
  }

  Future<void> _seen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenStartScreen', true);
    GoRouter.of(context).go('/signIn');
  }
}
