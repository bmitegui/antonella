import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/message_entity.dart';
import 'package:antonella/features/user/domain/usecases/get_messages_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessagesBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessagesUseCase;

  MessagesBloc({required this.getMessagesUseCase}) : super(MessagesInitial()) {
    on<GetMessagesEvent>(_onGetMessagesEventRequest);
  }

  Future<void> _onGetMessagesEventRequest(
      GetMessagesEvent event, Emitter<MessageState> emit) async {
        print('Se ejecuta');
    emit(MessagesLoading());
    final failureOrMessages = await getMessagesUseCase(NoParams());
    failureOrMessages.fold((failure) {
      print('Da eeror');
      emit(MessagesError(failure: failure));
    }, (messages) {
      print('se obtuvieron los mensajes');
      emit(MessagesLoaded(listMessages: messages));
    });
  }
}
