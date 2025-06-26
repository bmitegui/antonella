part of 'message_bloc.dart';

sealed class MessageState {
  const MessageState();
}

final class MessageInitial extends MessageState {}

final class MessageLoading extends MessageState {}

final class MessageLoaded extends MessageState {}

final class MessageError extends MessageState {
  final Failure failure;
  MessageError({required this.failure});
}