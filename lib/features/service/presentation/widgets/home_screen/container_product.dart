import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/presentation/bloc/detail_product_screen.dart';
import 'package:flutter/material.dart';

class ContainerProduct extends StatelessWidget {
  final List<String> image;
  final String text;
  const ContainerProduct({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
return Stack(
  children: [
    Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Column(
          children: [
            Image.network(image[0], width: 200, height: 200),
            SizedBox(height: 16),
            Text(text),
            SizedBox(height: 16),
            Text('Stock: 25'),
            Text('\$ 3.55')
          ]
        )
      ),
      Positioned(
          top: 8,
          right: 8,
          child:Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              color: Colors.amber,
            ), 
            child: IconButton(
              onPressed: () => navigateWithSlideTransition(context, DetailProductScreen(image: image)), 
              icon: Icon(Icons.add)
            )
          )
        )
  ],
);
  }
}