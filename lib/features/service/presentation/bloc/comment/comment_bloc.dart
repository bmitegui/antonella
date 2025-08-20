import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetServiceCommentsUseCase getCommentsUseCase;
  final AddServiceCommentUseCase addServiceCommentUseCase;

  CommentBloc(
      {required this.getCommentsUseCase,
      required this.addServiceCommentUseCase})
      : super(CommentsInitial()) {
    on<GetServiceCommentsEvent>(_onGetCommentsEventRequest);
    on<AddServiceCommentEvent>(_onAddServiceCommentEventRequest);
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

  Future<void> _onAddServiceCommentEventRequest(
      AddServiceCommentEvent event, Emitter<CommentState> emit) async {
    // Mantener estado anterior
    final previousState = state;

    emit(CommentsLoading());

    final failureOrSuccess = await addServiceCommentUseCase(
      AddServiceCommentParams(
        serviceId: event.serviceId,
        comment: event.comment,
        stars: event.stars,
      ),
    );

    failureOrSuccess.fold((failure) async {
      emit(CommentsError(failure: failure));
    }, (_) async {
      if (previousState is CommentsLoaded) {
        // Reemitir los comentarios que ya estaban cargados
        emit(CommentsLoaded(serviceComments: previousState.serviceComments));
      } else {
        // Si antes no había nada cargado, puedes emitir lista vacía o forzar un refresh
        emit(CommentsLoaded(serviceComments: []));
      }
      sl<ServiceBloc>().add(GetServicesEvent());
    });
  }
}
