part of 'password_bloc.dart';

sealed class PasswordEvent {
  const PasswordEvent();
}

final class PasswordInitialEvent extends PasswordEvent {}

final class PasswordCodeEvent extends PasswordEvent {
  final String email;
  PasswordCodeEvent({required this.email});
}
