import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFFE596A9),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFE6E9), shape: BoxShape.circle),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/icon/logo.png',
                              height: height * 0.25),
                          const SizedBox(height: 16),
                          Text('Descubre la reina\nque hay en ti',
                              textAlign: TextAlign.center,
                              style: textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFF4B7D)))
                        ])))));
  }
}
