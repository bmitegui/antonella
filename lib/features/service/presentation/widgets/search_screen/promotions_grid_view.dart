import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotion_view_details.dart';
import 'package:flutter/material.dart';

class PromotionsGridView extends StatelessWidget {
  final List<PromotionEntity> listPromotions;
  const PromotionsGridView({super.key, required this.listPromotions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: listPromotions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateWithSlideTransition(
                    context,
                    PromotionViewDetails(
                        promotionEntity: listPromotions[index])),
                child: CustomCachedNetworkImage(
                    imageUrl:
                        Environment.apiUrl + listPromotions[index].imageUrl[0]),
              );
            }));
  }
}
