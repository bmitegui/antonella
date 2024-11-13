// ignore_for_file: use_build_context_synchronously
import 'package:antonella/core/theme/app_theme.dart';
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
    return Scaffold(
        backgroundColor: themeClass.lightPrimaryColor,
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
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Descubre tu mejor versión aquí',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color:
                                                themeClass.lightEighthColor)),
                                const SizedBox(height: 16),
                                const Text(
                                    'Explora y agenda fácilmente citas para servicios de belleza, peluquería y bienestar, adaptados a tus necesidades y estilo.',
                                    textAlign: TextAlign.center),
                                const SizedBox(height: 64),
                                ElevatedButton(
                                    onPressed: () async => await _seen(),
                                    child: const Text('Iniciar'))
                              ]))))
            ])));
  }

  Future<void> _seen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenStartScreen', true);
    GoRouter.of(context).go('/signIn');
  }
}
