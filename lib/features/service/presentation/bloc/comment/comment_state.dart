part of 'comment_bloc.dart';

sealed class CommentState {
  const CommentState();
}

final class CommentsInitial extends CommentState {}

final class CommentsLoading extends CommentState {}

final class CommentsLoaded extends CommentState {
  final List<CommentEntity> serviceComments;
  CommentsLoaded({required this.serviceComments});
}

final class CommentsError extends CommentState {
  final Failure failure;
  CommentsError({required this.failure});
}
