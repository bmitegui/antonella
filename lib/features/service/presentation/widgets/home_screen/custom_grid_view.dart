import 'package:antonella/features/service/domain/entities/promotion_entity.dart';
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<PromotionEntity> listPromotions;
  const CustomGridView({super.key, required this.listPromotions});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: listPromotions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
                crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemBuilder: (context, index) {
              return ClipRRect(
                  child: Image.network(listPromotions[index].imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  }, errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  }));
            }));
  }
}
