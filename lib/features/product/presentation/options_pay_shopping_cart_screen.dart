import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:flutter/material.dart';

class OptionsPayShoppingCartScreen extends StatelessWidget {
  const OptionsPayShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: ArrowBack()),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {}, 
              child: Text('Efectivo')
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {}, 
              child: Text('Tarjeta')
            )
          ],
        ),
      ),
    );
  }
}