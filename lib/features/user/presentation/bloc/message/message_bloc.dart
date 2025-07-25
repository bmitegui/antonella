import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/usecases/get_messages_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessagesBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessagesUseCase;

  MessagesBloc({required this.getMessagesUseCase}) : super(MessagesInitial()) {
    on<GetMessagesEvent>(_onGetMessagesEventRequest);
    on<UpdateMessagesEvent>(_onUpdateMessagesEventRequest);
  }
  Future<void> _onUpdateMessagesEventRequest(
      UpdateMessagesEvent event, Emitter<MessageState> emit) async {
    MessageEntity newMessage = MessageEntity(
        messageId: event.messageId,
        senderId: event.senderId,
        userId: event.userId,
        content: event.content,
        dateTime: DateTime.now(),
        messageType: stringToMessageType(event.type));
    if (state is MessagesLoaded) {
      final currentMessages =
          List<MessageEntity>.from((state as MessagesLoaded).listMessages);
      currentMessages.insert(0, newMessage);
      emit(MessagesLoaded(listMessages: currentMessages));
    }
  }

  Future<void> _onGetMessagesEventRequest(
      GetMessagesEvent event, Emitter<MessageState> emit) async {
    final currentState = state;
    if (currentState is MessagesLoading) {
      return;
    }
    final failureOrMessages = await getMessagesUseCase(NoParams());

    failureOrMessages.fold(
      (failure) {
        // Si ya se habían cargado mensajes antes, los mantenemos
        if (currentState is MessagesLoaded) {
          emit(MessagesError(failure: failure));
          emit(MessagesLoaded(listMessages: currentState.listMessages));
        } else {
          emit(MessagesError(failure: failure));
        }
      },
      (messages) {
        emit(MessagesLoaded(listMessages: messages));
      },
    );
  }
}
