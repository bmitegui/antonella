import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:antonella/features/service/presentation/widgets/search_screen/promotion_view_details.dart';
import 'package:flutter/material.dart';

class PromotionsGridView extends StatefulWidget {
  final List<PromotionEntity> listPromotions;
  const PromotionsGridView({super.key, required this.listPromotions});

  @override
  State<PromotionsGridView> createState() => _PromotionsGridViewState();
}

class _PromotionsGridViewState extends State<PromotionsGridView> {
  Set<String> selectedPromotionIds = {};

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: widget.listPromotions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            final promotion = widget.listPromotions[index];
            final isSelected = selectedPromotionIds.contains(promotion.id);

            return Container(
              height: 300,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.surface),
              child: GestureDetector(
                onTap: () => navigateWithSlideTransition(
                    context,
                    PromotionViewDetails(
                        promotionEntity: widget.listPromotions[index], 
                        selected: (wasSelected) {
                          if (wasSelected) {
                            setState(() {
                              selectedPromotionIds.add(widget.listPromotions[index].id);
                            });
                          }
                        })),
                child: CustomCachedNetworkImage(
                    imageUrl:
                        Environment.apiUrl + widget.listPromotions[index].images[0]),
              ),
            );
          }),
    );
  }
}
