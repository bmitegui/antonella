import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  final String imageUrl;
  final String rating;
  final String date;
  final String comment;
  const CommentContainer(
      {super.key,
      required this.imageUrl,
      required this.rating,
      required this.date,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
            width: 32,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: CustomCachedNetworkImage(imageUrl: imageUrl)),
        const SizedBox(width: 8),
        Column(children: [
          Text('Juliana Andrea Daza'),
          Row(children: [
            Icon(Icons.star, color: Colors.amber, size: 16),
            Icon(Icons.star, color: Colors.amber, size: 16),
            Icon(Icons.star, color: Colors.amber, size: 16),
            Icon(Icons.star, color: Colors.amber, size: 16),
            Icon(Icons.star_border, size: 16),
            const SizedBox(width: 8),
            Text('14/02/2025',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey))
          ])
        ])
      ]),
      const SizedBox(height: 8),
      Text(comment)
    ]);
  }
}
