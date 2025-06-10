part of 'password_bloc.dart';

sealed class PasswordEvent {
  const PasswordEvent();
}

final class PasswordInitialEvent extends PasswordEvent {}

final class PasswordCodeEvent extends PasswordEvent {
  final String email;
  PasswordCodeEvent({required this.email});
}

final class PasswordResetEvent extends PasswordEvent {
  final String id;
  final String password;
  PasswordResetEvent({required this.id, required this.password});
}
