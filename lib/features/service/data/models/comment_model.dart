import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/domain/entities/comment_entity.dart';
import 'package:antonella/features/user/data/models/user_model.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.id,
      required super.rating,
      required super.dateTime,
      required super.comment,
      required super.userEntity});

  factory CommentModel.fromJson(
      Map<String, dynamic> json, UserModel userModel) {
    return CommentModel(
        id: '${json['id']}',
        rating: json['starts'].toDouble(),
        dateTime: parseStringToDate(json['created_at']).toLocal(),
        userEntity: userModel,
        comment: capitalize(json['content']));
  }
}
