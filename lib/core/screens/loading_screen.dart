import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xffdf4362),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    // decoration: const BoxDecoration(
                    //     color: Color(0xffdf4362)),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/logo.png',
                              height: height * 0.25),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          const SizedBox(height: 16),
                          Text(texts.discover_the_queen,
                              textAlign: TextAlign.center,
                              style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white60))
                        ])))));
  }
}
