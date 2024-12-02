part of 'service_form_bloc.dart';

sealed class ServiceFormEvent {
  const ServiceFormEvent();
}

final class ServiceFormInitialEvent extends ServiceFormEvent {}

final class GetListServiceFormEvent extends ServiceFormEvent {
  final String category;
  GetListServiceFormEvent({required this.category});
}

final class UpdateAnswerEvent extends ServiceFormEvent {
  final List<ServiceFormEntity> listServiceForms;
  final String id;
  final dynamic answer;
  UpdateAnswerEvent(
      {required this.id, required this.answer, required this.listServiceForms});
}
