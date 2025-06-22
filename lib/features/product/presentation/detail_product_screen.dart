import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
    return BlocConsumer<ProductsSelectedBloc, ProductsSelectedState>(
        listener: (context, state) {
      if (state is ProductsSelectedLoaded) {
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.success(message: 'Producto agregado'));
        Navigator.pop(context);
      }
    }, builder: (context, state) {
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
                    Text('\$ ${widget.productEntity.price}',
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(width: 8),
                    QuantitySelectionWidget(
                      stock: stock,
                      onQuantityChanged: (quantity) {
                        setState(() {
                          selectedQuantity = quantity;
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    CustomElevatedButton(
                        onPressed: () {
                          sl<ProductsSelectedBloc>().add(AddProductEvent(
                              product: widget.productEntity,
                              cant: selectedQuantity));
                        },
                        text: 'Agregar')
                  ])),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                ImagesScrollview(images: widget.productEntity.images),
                SizedBox(height: 16),
                Text(widget.productEntity.nombre),
                SizedBox(height: 16),
                Text('Volumen: ${widget.productEntity.volume}'),
                Divider(),
                Text('Descripción'),
                SizedBox(height: 16),
                Text(widget.productEntity.description)
              ])));
    });
  }
}
