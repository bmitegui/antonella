part of 'profile_user_bloc.dart';


sealed class ProfileUserState {
  const ProfileUserState();
}

final class ProfileUserInitial extends ProfileUserState {}

final class ProfileUserLoading extends ProfileUserState {}

final class ProfileUserLoaded extends ProfileUserState {
  ProfileUserLoaded();
}

final class ProfileUserError extends ProfileUserState {
  final Failure failure;
  ProfileUserError({required this.failure});
}