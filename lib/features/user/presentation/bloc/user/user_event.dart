part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserInitialEvent extends UserEvent {}

final class SignInEvent extends UserEvent {
  final String email;
  final String password;
  final bool rememberMe;
  SignInEvent(
      {required this.email, required this.password, required this.rememberMe});
}

final class SignOutEvent extends UserEvent {
  final UserEntity userEntity;
  SignOutEvent({required this.userEntity});
}

final class SignUpEvent extends UserEvent {
  final String email;
  final String name;
  final String password;
  final String birthdate;

  SignUpEvent(
      {required this.email,
      required this.name,
      required this.password,
      required this.birthdate});
}

final class CheckAuthenticationEvent extends UserEvent {}
