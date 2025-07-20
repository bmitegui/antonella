// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: colorScheme.secondary,
        body: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  color: colorScheme.primaryContainer, height: height / 2)),
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Container(
                    padding: EdgeInsets.all(64),
                    decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        shape: BoxShape.circle),
                    child:
                        Image.asset('assets/icon/logo.png', height: height / 5))
              ])),
          Positioned(
              top: height / 1.6,
              left: 32,
              right: 32,
              child: Text(
                  'Explora y agenda fácilmente citas para servicios de belleza, peluqueria y bienestar, adaptados a tu necesidad y estilo',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold))),
          Positioned(
              bottom: 64,
              left: 128,
              right: 128,
              child: FilledButton(
                  onPressed: () async => await _seen(),
                  child: Text('Iniciar')))
        ]));
  }

  Future<void> _seen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenStartScreen', true);
    GoRouter.of(context).go('/signIn');
  }
}
