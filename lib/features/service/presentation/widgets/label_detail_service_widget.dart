import 'package:flutter/material.dart';

class LabelDetailServiceWidget extends StatelessWidget {
  final String category;
  final String rating;
  final String duration;
  const LabelDetailServiceWidget({super.key, required this.category, required this.rating, required this.duration});

  @override
  Widget build(BuildContext context) {
    final n = (MediaQuery.of(context).size.width) / 16;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildLabelIcon(title: category, icon: Icons.local_offer, colorIcon: Colors.pink, sizeIcon: n),
      buildLabelIcon(title: '$rating [45]', icon: Icons.star, colorIcon: Colors.amber, sizeIcon: n),
      buildLabelIcon(title: '$duration min', icon: Icons.access_time_filled, colorIcon: Colors.grey, sizeIcon: n)
    ]);
  }

  Widget buildLabelIcon(
      {required String title,
      required IconData icon,
      required Color colorIcon,
      required double sizeIcon}) {
    return Row(children: [
      Icon(
        icon,
        color: colorIcon,
        size: sizeIcon,
      ),
      const SizedBox(width: 8),
      Text(title)
    ]);
  }
}
