import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:flutter/material.dart';

class DetailProductScreen extends StatelessWidget {
  final ProductEntity productEntity;
  const DetailProductScreen({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    int stock = 10;
    return CustomScaffold(
      paddingScroll: EdgeInsets.all(0),
      leading: ArrowBack(),
      text: 'Detalles',
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '\$ ${productEntity.price}',
                  style: Theme.of(context).textTheme.titleMedium),
              SizedBox(width:8),
              QuantitySelectionWidget(stock: stock),
              SizedBox(width:8),
              CustomElevatedButton(
                onPressed: () {  },
                text: 'Agregar al carrito'
              )
          ])),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ImagesScrollview(images: productEntity.images),
            SizedBox(height:16),
            Text(productEntity.nombre),
            SizedBox(height:16),
            Text('Volumen: ${productEntity.volume}'),
            Divider(),
            Text('Description'),
            SizedBox(height:16),
            Text(productEntity.description),
          ],
        ),
      ),
      
    );
  }
}