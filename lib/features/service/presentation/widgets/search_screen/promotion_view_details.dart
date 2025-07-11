import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/widgets/arrow_back.dart';
import 'package:antonella/core/widgets/custom_elevated_button.dart';
import 'package:antonella/core/widgets/custom_scaffold.dart';
import 'package:antonella/core/widgets/images_scrollview.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PromotionViewDetails extends StatefulWidget {
  final PromotionEntity promotionEntity;
  const PromotionViewDetails({super.key, required this.promotionEntity});

  @override
  State<PromotionViewDetails> createState() => _PromotionViewDetailsState();
}

class _PromotionViewDetailsState extends State<PromotionViewDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        paddingScroll: EdgeInsets.all(0),
        leading: ArrowBack(),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
            child: CustomElevatedButton(
                onPressed: () {
                  sl<PromotionCartBloc>().add(AddPromotionToCartEvent(promotionEntity: widget.promotionEntity));
                  
                  showTopSnackBar(Overlay.of(context),
                      CustomSnackBar.success(message: 'Producto agregado'));
                  Navigator.pop(context);
                },
                text: 'Agregar al carrito')),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              ImagesScrollview(images: widget.promotionEntity.imageUrl),
              SizedBox(height: 16),
              Text('Servicios aplicado a esta promoción'),
              SizedBox(height: 16),
              Text('Corte de cabello'),
              SizedBox(height: 16),
              Text('Manicure y Pedicure'),
              Divider(),
              Text('Descripción'),
              SizedBox(height: 16),
              Text('Este es un servicio que aplica para todas las edades')
            ])));
  }
}
