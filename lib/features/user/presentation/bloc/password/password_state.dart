part of 'password_bloc.dart';

sealed class PasswordState {
  const PasswordState();
}

final class PasswordInitial extends PasswordState {}

final class PasswordLoading extends PasswordState {}

final class PasswordReseted extends PasswordState {}

final class PasswordLoaded extends PasswordState {
  final String code;
  final String userId;
  PasswordLoaded({required this.code, required this.userId});
}

final class PasswordUnauthenticated extends PasswordState {}

final class PasswordError extends PasswordState {
  final String message;
  PasswordError({required this.message});
}
