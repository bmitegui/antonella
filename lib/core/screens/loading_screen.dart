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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE596A9), // fondo rosa oscuro
      body: Center(
        child: Container(
          height: height * 1.1, // tamaño del círculo
          width: width * 1.1, // ancho del círculo
          decoration: const BoxDecoration(
            color: Color(0xFFFFE6E9), // rosa claro
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/icon/logo.png',
                height: height * 0.25,
              ),

              const SizedBox(height: 20),

              // Texto dentro del círculo
              Text(
                'Descubre la reina\nque hay en ti',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF4B7D), // rojo
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
