import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.id,
      required super.name,
      required super.rating,
      required super.dateTime,
      required super.urlImage,
      required super.comment});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        dateTime: parseStringToDate(json['dateTime']),
        urlImage: json['urlImage'],
        comment: json['comment']);
  }
}
