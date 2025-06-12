import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final starIndex = index + 1;
          if (rating >= starIndex) {
            return const Icon(Icons.star, color: Colors.amber);
          } else if (rating >= starIndex - 0.5) {
            return const Icon(Icons.star_half, color: Colors.amber);
          } else {
            return const Icon(Icons.star_border, color: Colors.amber);
          }
        }));
  }
}
