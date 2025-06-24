import 'package:antonella/core/error/failures.dart';
import 'package:antonella/features/service/domain/entities/entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'service_form_event.dart';
part 'service_form_state.dart';

class ServiceFormBloc extends Bloc<ServiceFormEvent, ServiceFormState> {
  ServiceFormBloc() : super(ServiceFormInitial()) {
    on<AnswerQuestionEvent>(_onAnswerQuestionEventRequest);
    on<SelectServiceEvent>(_onSelectServiceEventRequest);
  }

  Future<void> _onSelectServiceEventRequest(
    SelectServiceEvent event,
    Emitter<ServiceFormState> emit,
  ) async {
    emit(ServiceFormLoaded(service: event.service));
  }

  Future<void> _onAnswerQuestionEventRequest(
    AnswerQuestionEvent event,
    Emitter<ServiceFormState> emit,
  ) async {
    final currentState = state;
    if (currentState is ServiceFormLoaded) {
      final oldQuestions = currentState.service.questions;
      final index = oldQuestions.indexWhere((q) => q.id == event.questionId);

      if (index != -1) {
        final updatedQuestion =
            oldQuestions[index].copyWith(answer: event.answer);
        final updatedQuestions = List<QuestionEntity>.from(oldQuestions)
          ..[index] = updatedQuestion;

        final updatedService = currentState.service.copyWith(
          questions: updatedQuestions,
        );

        emit(ServiceFormLoading());
        emit(ServiceFormLoaded(service: updatedService));
      }
    }
  }
}
