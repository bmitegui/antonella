part of 'message_bloc.dart';

sealed class MessageEvent {
  const MessageEvent();
}

final class MessageInitialEvent extends MessageEvent {}

final class GetMessagesEvent extends MessageEvent {}
