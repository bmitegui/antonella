//staless  --> no cambian de estado, son estaticos
//statefull DAWM   --> si cambian

import 'package:flutter/material.dart';

class PruebaWidget extends StatelessWidget {
  const PruebaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      
      color: Colors.black,
      child: Icon(
        Icons.arrow_back,
        color: Colors.amber,
      ),
    );
  }
}
