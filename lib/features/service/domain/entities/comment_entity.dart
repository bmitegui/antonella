import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final double rating;
  final DateTime dateTime;
  final String comment;
  final UserEntity userEntity;

  const CommentEntity(
      {required this.id,
      required this.rating,
      required this.dateTime,
      required this.comment,
      required this.userEntity});

  @override
  List<Object?> get props => [id];
}
