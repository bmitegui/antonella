part of 'send_message_bloc.dart';

sealed class SendMessageState {
  const SendMessageState();
}

final class SendMessagesInitial extends SendMessageState {}

final class SendMessagesLoading extends SendMessageState {}

final class SendMessagesLoaded extends SendMessageState {
  SendMessagesLoaded();
}

final class SendMessagesError extends SendMessageState {
  final Failure failure;
  SendMessagesError({required this.failure});
}