part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent {
  const ProfileUserEvent();
}

final class ProfileUserInitialEvent extends ProfileUserEvent {}

class UpdateUserProfileEvent extends ProfileUserEvent {
  final String userId;
  final String? base64Photo;
  final String? name;
  final String? phoneNumber;
  final String? gmail;

  UpdateUserProfileEvent(
      {required this.userId,
      required this.base64Photo,
      required this.name,
      required this.phoneNumber,
      required this.gmail});
}
