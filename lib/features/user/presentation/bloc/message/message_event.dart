part of 'message_bloc.dart';

sealed class MessageEvent {
  const MessageEvent();
}

final class MessageInitialEvent extends MessageEvent {}

final class GetMessagesEvent extends MessageEvent {}

final class UpdateMessagesEvent extends MessageEvent {
  final String content;
  final String type;
  final String userId;
  final String messageId;
  final String senderId;
  UpdateMessagesEvent(
      {required this.content,
      required this.type,
      required this.userId,
      required this.messageId,
      required this.senderId});
}
