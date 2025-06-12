part of 'comment_bloc.dart';

sealed class CommentEvent {
  const CommentEvent();
}

final class CommentInitialEvent extends CommentEvent {}

final class GetServiceCommentsEvent extends CommentEvent {
  final String serviceId;
  GetServiceCommentsEvent({required this.serviceId});
}
