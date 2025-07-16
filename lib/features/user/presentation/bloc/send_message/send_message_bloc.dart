import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/usecases/send_messages_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final SendMessagesUseCase sendMessagesUseCase;

  SendMessageBloc({required this.sendMessagesUseCase})
      : super(SendMessagesInitial()) {
    on<SendMessagesEvent>(_onSendMessagesEventRequest);
  }

  Future<void> _onSendMessagesEventRequest(
      SendMessagesEvent event, Emitter<SendMessageState> emit) async {
    emit(SendMessagesLoading());
    final failureOrMessages = await sendMessagesUseCase(SendMessageParams(
        userId: event.userId, content: event.content, type: event.type));
    failureOrMessages.fold((failure) {
      emit(SendMessagesError(failure: failure));
    }, (message) {
      emit(SendMessagesLoaded());
    });
  }
}
