import 'package:flutter/material.dart';

class PromotionsGridView extends StatelessWidget {
  const PromotionsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
  // final List<PromotionEntity> listPromotions;
  // const PromotionsGridView({super.key, required this.listPromotions});

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: GridView.builder(
  //           itemCount: listPromotions.length,
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               mainAxisExtent: 200,
  //               crossAxisCount: 2,
  //               crossAxisSpacing: 8.0,
  //               mainAxisSpacing: 8.0),
  //           itemBuilder: (context, index) {
  //             return CustomCachedNetworkImage(
  //                 imageUrl: listPromotions[index].imageUrl);
  //           }));
  // }
}
