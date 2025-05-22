import 'package:flutter/material.dart';

class ActivityStateWidget extends StatelessWidget {
  const ActivityStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                )
              ),
              const Text('No disponible')
            ]
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                )
              ),
              const Text('Seleccionado')
            ]
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                )
              ),
              const Text('Disponible')
            ]
          )
        ],
        )
    );
  }
}