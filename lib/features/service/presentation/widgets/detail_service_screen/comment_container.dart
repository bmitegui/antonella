import 'package:antonella/core/constant/environment.dart';
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
            width: 32,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            clipBehavior: Clip.hardEdge,
            child: commentEntity.userEntity.photoUrl != null
                ? CustomCachedNetworkImage(
                    imageUrl:
                        Environment.apiUrl + commentEntity.userEntity.photoUrl!)
                : Icon(Icons.person)),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(commentEntity.userEntity.name, style: bodyBlack54Style(context)),
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
      Text(commentEntity.comment, style: bodyBlack54Style(context))
    ]);
  }
}
