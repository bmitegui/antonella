import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/shopping_cart/cart_bloc.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:antonella/features/product/presentation/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductScreen extends StatefulWidget {
  final ProductEntity productEntity;
  const DetailProductScreen({super.key, required this.productEntity});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    int stock = 10;
    return BlocBuilder<CartBloc, CartState> (builder: (context, state) {
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
                      '\$ ${widget.productEntity.price}',
                      style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(width:8),
                  QuantitySelectionWidget(
                    stock: stock,
                    onQuantityChanged: (quantity) {
                      setState(() {
                        selectedQuantity = quantity;
                      });
                    },
                  ),
                  SizedBox(width:8),
                  CustomElevatedButton(
                    onPressed: () { 
                      
                    },
                    text: 'Agregar al carrito'
                  )
              ])),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ImagesScrollview(images: widget.productEntity.images),
                SizedBox(height:16),
                Text(widget.productEntity.nombre),
                SizedBox(height:16),
                Text('Volumen: ${widget.productEntity.volume}'),
                Divider(),
                Text('Descripción'),
                SizedBox(height:16),
                Text(widget.productEntity.description),
              ],
            ),
          ),
          
        );
      } 
    );
    
  }
}