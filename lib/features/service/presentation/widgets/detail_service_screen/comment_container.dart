import 'package:antonella/core/utils/util.dart';
import 'package:antonella/core/widgets/custom_cached_network_image.dart';
import 'package:antonella/core/widgets/rating_stars_widget.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter/material.dart';

class CommentContainer extends StatelessWidget {
  final CommentEntity commentEntity;
  const CommentContainer({super.key, required this.commentEntity});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
            width: 32,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: CustomCachedNetworkImage(imageUrl: commentEntity.urlImage)),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Juliana Andrea Daza'),
          Row(children: [
            RatingStars(rating: commentEntity.rating),
            const SizedBox(width: 16),
            Text(formatDateToString(commentEntity.dateTime),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey))
          ])
        ])
      ]),
      const SizedBox(height: 8),
      Text(commentEntity.comment)
    ]);
  }
}
