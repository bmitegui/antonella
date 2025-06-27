part of 'form_done_bloc.dart';

sealed class FormDoneState {
  const FormDoneState();
}

final class FormDoneInitial extends FormDoneState {}

final class FormDoneLoading extends FormDoneState {}

final class FormDoneLoaded extends FormDoneState {
  final List<QuestionEntity> questions;
  FormDoneLoaded({required this.questions});
}

final class FormDoneError extends FormDoneState {
  final Failure failure;
  FormDoneError({required this.failure});
}
