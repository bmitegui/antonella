import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/show_warning_dialog_widget.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/quantity_selection_widget.dart';
import 'package:antonella/features/service/presentation/bloc/services_selected/services_selected_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCartItem extends StatelessWidget {
  final ProductEntity productEntity;
  final int quantity;
  final void Function(int) onQuantityChanged;

  const BuildCartItem({
    super.key,
    required this.productEntity,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () async => await showWarningDialog(
                  context: context,
                  title: "Eliminar producto",
                  message:
                      "¿Está seguro de que desea eliminar el producto seleccionado?",
                  textOnAccept: "Eliminar",
                  onAccept: () {
                    context
                        .read<ServicesSelectedBloc>()
                        .add(DeleteProductEvent(product: productEntity));
                  }),
              icon: Icon(Icons.delete, color: Colors.red)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 64,
                  child: CustomCachedNetworkImage(
                      imageUrl:
                          Environment.apiUrl + productEntity.images.first),
                ),
                const SizedBox(height: 4),
                Text(productEntity.nombre, style: bodyBlack54Style(context))
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              QuantitySelectionWidget(
                productEntity: productEntity,
                quantity: quantity,
                onChanged: onQuantityChanged,
              ),
              const SizedBox(height: 16),
              Text(
                '\$${productEntity.price}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
