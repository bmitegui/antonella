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
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: CustomCachedNetworkImage(imageUrl: imageUrl)),
        title: Row(children: [
          Text('Juliana Andrea Daza'),
          Column(children: [
            Row(children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star, color: Colors.amber, size: 16),
              Icon(Icons.star_border, size: 16),
              SizedBox(width: 16),
              Text('14/02/2025',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black))
            ])
          ])
        ]),
        subtitle: Text(comment, style: TextStyle(fontSize: 14)));
  }
}
