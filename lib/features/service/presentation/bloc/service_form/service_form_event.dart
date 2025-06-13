part of 'service_form_bloc.dart';

sealed class ServiceFormEvent {
  const ServiceFormEvent();
}

final class ServiceFormInitialEvent extends ServiceFormEvent {}

final class AnswerQuestionEvent extends ServiceFormEvent {
  final String questionId;
  final dynamic answer;
  AnswerQuestionEvent({required this.questionId, required this.answer});
}

final class SelectServiceEvent extends ServiceFormEvent {
  final ServiceEntity service;
  SelectServiceEvent({required this.service});
}
