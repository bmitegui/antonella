part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent{
  const ProfileUserEvent();
}

final class ProfileUserInitialEvent extends ProfileUserEvent {}

class UpdateUserProfilePhotoEvent extends ProfileUserEvent {
  final String userId;
  final String base64Photo;

  UpdateUserProfilePhotoEvent({
    required this.userId,
    required this.base64Photo,
  });
}