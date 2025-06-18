import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/detail_product_screen.dart';
import 'package:flutter/material.dart';

class ContainerProduct extends StatelessWidget {
  final ProductEntity productEntity;
  const ContainerProduct({super.key, required this.productEntity});

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
            Image.network(productEntity.images[0], width: 200, height: 200),
            SizedBox(height: 16),
            Text(productEntity.type.toString()),
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
              onPressed: () => navigateWithSlideTransition(context, DetailProductScreen(productEntity: productEntity)), 
              icon: Icon(Icons.add)
            )
          )
        )
  ],
);
  }
}