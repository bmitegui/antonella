import 'package:antonella/core/widgets/custom_local_svg_image.dart';
import 'package:flutter/material.dart';

class LabelDetailServiceWidget extends StatelessWidget {
  final String category;
  final double rating;
  final String duration;
  const LabelDetailServiceWidget(
      {super.key,
      required this.category,
      required this.rating,
      required this.duration});

  @override
  Widget build(BuildContext context) {
    final n = (MediaQuery.of(context).size.width) / 16;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildLabelIcon(
          title: category,
          icon: Icons.local_offer,
          colorIcon: Colors.pink,
          sizeIcon: n,
          context: context),
      buildLabelIcon(
          title: '$rating',
          icon: Icons.star,
          colorIcon: Colors.amber,
          sizeIcon: n,
          context: context),
      buildLabelIcon(
          title: duration,
          icon: null,
          colorIcon: Colors.grey,
          sizeIcon: n,
          context: context)
    ]);
  }

  Widget buildLabelIcon(
      {required String title,
      required IconData? icon,
      required Color colorIcon,
      required double sizeIcon,
      required BuildContext context}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(children: [
      icon!=null?Icon(
        icon,
        color: colorIcon,
        size: sizeIcon,
      ):CustomLocalSvgImage(assetPath: 'assets/svg/reloj.svg',height: 20, color: colorScheme.primary),
      const SizedBox(width: 8),
      Text(title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: colorScheme.onSurface))
    ]);
  }
}
