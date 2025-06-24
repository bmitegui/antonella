import 'package:antonella/core/error/error.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetServiceCommentsUseCase getCommentsUseCase;

  CommentBloc({required this.getCommentsUseCase}) : super(CommentsInitial()) {
    on<GetServiceCommentsEvent>(_onGetCommentsEventRequest);
  }

  Future<void> _onGetCommentsEventRequest(
      GetServiceCommentsEvent event, Emitter<CommentState> emit) async {
    emit(CommentsLoading());
    final failureOrSuccess = await getCommentsUseCase(
        GetServiceCommentsParams(serviceId: event.serviceId));
    failureOrSuccess.fold((failure) async {
      emit(CommentsError(failure: failure));
    }, (serviceComments) async {
      emit(CommentsLoaded(serviceComments: serviceComments));
    });
  }
}
