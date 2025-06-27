part of 'message_bloc.dart';

sealed class MessageState {
  const MessageState();
}

final class MessagesInitial extends MessageState {}

final class MessagesLoading extends MessageState {}

final class MessagesLoaded extends MessageState {
  final List<MessageEntity> listMessages;
  MessagesLoaded({required this.listMessages});
}

final class MessagesError extends MessageState {
  final Failure failure;
  MessagesError({required this.failure});
}