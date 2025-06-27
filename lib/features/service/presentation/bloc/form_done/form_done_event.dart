part of 'form_done_bloc.dart';

sealed class FormDoneEvent {
  const FormDoneEvent();
}

final class FormDoneInitialEvent extends FormDoneEvent {}

final class GetFormDoneEvent extends FormDoneEvent {
  final String serviceItemId;
  GetFormDoneEvent({required this.serviceItemId});
}
