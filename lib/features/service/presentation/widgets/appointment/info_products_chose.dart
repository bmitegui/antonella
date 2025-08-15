import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/presentation/widgets/appointment/info_list_products.dart';
import 'package:flutter/material.dart';

class InfoProductsChosen extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoProductsChosen({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final texts = AppLocalizations.of(context)!;
    final products = orderEntity.products; // Lista de ProductEntity

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Productos escogidos: ${products.length}'),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    scrollControlDisabledMaxHeightRatio: 1,
                    isScrollControlled: true,
                    backgroundColor: const Color(0xFFF0F0F0),
                    context: context,
                    builder: (BuildContext context) {
                      return InfoListProducts(orderEntity: orderEntity);
                    },
                  );
                },
                child: Text(
                  texts.see_more,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: const Color(0xFFF44565),
                        decoration: TextDecoration.underline,
                        decorationColor: const Color(0xFFF44565),
                      ),
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 16),
          if (products.isNotEmpty)
            Column(
              children: products.take(3).map((product) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images.isNotEmpty
                              ? Environment.apiUrl + product.images.first
                              : 'https://via.placeholder.com/50',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          product.nombre,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
            Text(
              'No hay productos en la orden',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
