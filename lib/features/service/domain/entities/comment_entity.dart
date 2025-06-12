import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String name;
  final double rating;
  final DateTime dateTime;
  final String urlImage;
  final String comment;

  const CommentEntity(
      {required this.id,
      required this.name,
      required this.rating,
      required this.dateTime,
      required this.urlImage,
      required this.comment});

  @override
  List<Object?> get props => [id];
}
