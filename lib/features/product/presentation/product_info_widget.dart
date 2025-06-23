import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/product/domain/entities/product_entity.dart';
import 'package:antonella/features/product/presentation/detail_product_screen.dart';
import 'package:antonella/features/product/presentation/bloc/products_selected/products_selected_bloc.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/service_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductInfoWidget({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsSelectedBloc, ProductsSelectedState>(
        builder: (context, state) {
      int index = -1;

      bool isSelected = false;
      if (state is ProductsSelectedLoaded) {
        index = state.products
            .indexWhere((service) => service.id == productEntity.id);
        if (index != -1) {
          isSelected = true;
        }
      }

      return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
              onTap: () {
                navigateWithSlideTransition(
                    context, DetailProductScreen(productEntity: productEntity));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          isSelected ? Color(0xFFF44565) : Colors.transparent),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        ServiceImageNetwork(
                            urlImage:
                                Environment.apiUrl + productEntity.images[0]),
                        const SizedBox(height: 8),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(productEntity.nombre,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color:
                                            isSelected ? Colors.white : null))),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(productEntity.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: isSelected
                                            ? Colors.white70
                                            : Colors.grey))),
                        const SizedBox(height: 8),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, bottom: 8),
                                child: Text(
                                    '\$${productEntity.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Color(0xFFF44565)))))
                      ]))));
    });
  }
}
