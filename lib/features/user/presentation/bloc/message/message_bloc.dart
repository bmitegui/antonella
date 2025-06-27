import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/usecases/usecase.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/usecases.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessagesBloc extends Bloc<MessageEvent, MessageState> {
  final GetMessagesUseCase getMessagesUseCase;

  MessagesBloc(
      {required this.getMessagesUseCase})
      : super(MessagesInitial()) {
    on<GetMessagesEvent>(_onGetMessagesEventRequest);
  }

  Future<void> _onGetMessagesEventRequest(
      GetMessagesEvent event, Emitter<MessageState> emit) async {
        print('inicia');
    emit(MessagesLoading());
    final failureOrMessages = await getMessagesUseCase(NoParams());
    failureOrMessages.fold((failure) {
      emit(MessagesError(failure: failure));
      
    },
    (messages) {
      emit(MessagesLoaded(listMessages: messages));
      

    }
    
    );
  }
}
