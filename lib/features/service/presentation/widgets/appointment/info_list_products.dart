import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/widgets/custom_modal_bottom_sheet_widget.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';

class InfoListProducts extends StatelessWidget {
  final OrderEntity orderEntity;
  const InfoListProducts({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return CustomModalBottomSheetWidget(
      closeAction: false,
      title: 'Productos escogidos',
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: orderEntity.products
                .map((product) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InfoProductContainer(productEntity: product),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class InfoProductContainer extends StatelessWidget {
  final ProductEntity productEntity;
  const InfoProductContainer({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  productEntity.images.isNotEmpty
                      ? Environment.apiUrl + productEntity.images.first
                      : 'https://via.placeholder.com/60',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.nombre,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      productEntity.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 25),
              const Icon(Icons.attach_money),
              const SizedBox(width: 20),
              Text('\$${productEntity.price.toStringAsFixed(2)}'),
              const Spacer(),
              Text('Stock: ${productEntity.stock}'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductDetailModal extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailModal({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productEntity.nombre,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(productEntity.description),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              productEntity.images.isNotEmpty
                  ? productEntity.images.first
                  : 'https://via.placeholder.com/200',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text('Precio: \$${productEntity.price.toStringAsFixed(2)}'),
          Text('Stock disponible: ${productEntity.stock}'),
        ],
      ),
    );
  }
}
