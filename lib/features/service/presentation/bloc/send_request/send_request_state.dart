part of 'send_request_bloc.dart';

sealed class SendRequestState {
  const SendRequestState();
}

final class SendRequestInitial extends SendRequestState {}

final class SendRequestLoading extends SendRequestState {}

final class SendRequestLoaded extends SendRequestState {}

final class SendRequestError extends SendRequestState {
  final Failure failure;
  SendRequestError({required this.failure});
}
