part of 'password_bloc.dart';

sealed class PasswordState {
  const PasswordState();
}

final class PasswordInitial extends PasswordState {}

final class PasswordLoading extends PasswordState {}

final class PasswordLoaded extends PasswordState {
  final String code;
  PasswordLoaded({required this.code});
}

final class PasswordUnauthenticated extends PasswordState {}

final class PasswordError extends PasswordState {
  final String message;
  PasswordError({required this.message});
}
