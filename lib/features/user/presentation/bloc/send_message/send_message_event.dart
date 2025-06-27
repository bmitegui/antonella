part of 'send_message_bloc.dart';

sealed class SendMessageEvent {
  const SendMessageEvent();
}

final class SendMessageInitialEvent extends SendMessageEvent {}

final class SendMessagesEvent extends SendMessageEvent {
  final String userId;
  final String content;
  final MessageType type;

  SendMessagesEvent(
      {required this.userId, required this.content, required this.type});
}
