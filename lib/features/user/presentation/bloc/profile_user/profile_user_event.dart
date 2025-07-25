part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent{
  const ProfileUserEvent();
}

final class ProfileUserInitialEvent extends ProfileUserEvent {}

final class GetProfileUser extends ProfileUserEvent {}