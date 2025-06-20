part of 'user_bloc.dart';

sealed class UserEvent {
  const UserEvent();
}

final class UserInitialEvent extends UserEvent {}

final class SignInEvent extends UserEvent {
  final String account;
  final String password;
  final bool rememberMe;
  final bool checkAuthentication;
  SignInEvent(
      {required this.account,
      required this.password,
      required this.rememberMe,
      this.checkAuthentication = false});
}

final class SignOutEvent extends UserEvent {
  final UserEntity? userEntity;
  SignOutEvent({required this.userEntity});
}

final class SignUpEvent extends UserEvent {
  final String account;
  final String name;
  final String password;
  final String birthdate;
  final String? genero;
  final String phoneNumber;
  final String dni;

  SignUpEvent(
      {required this.account,
      required this.name,
      required this.password,
      required this.birthdate,
      required this.genero,
      required this.dni,
      required this.phoneNumber});
}

final class CheckAuthenticationEvent extends UserEvent {}

final class ResetUserEvent extends UserEvent {}