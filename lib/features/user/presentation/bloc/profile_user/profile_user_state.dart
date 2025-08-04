part of 'profile_user_bloc.dart';


sealed class ProfileUserState {
  const ProfileUserState();
}

final class ProfileUserInitial extends ProfileUserState {}

final class ProfileUserLoading extends ProfileUserState {}

final class ProfileUserLoaded extends ProfileUserState {
  final String? photoBase64;
  ProfileUserLoaded({this.photoBase64});
}

final class ProfileUserError extends ProfileUserState {
  final Failure failure;
  ProfileUserError({required this.failure});
}