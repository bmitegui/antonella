part of 'notifications_bloc.dart';

sealed class NotificationsState {
  const NotificationsState();
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsLoaded extends NotificationsState {
  final List<NotificationEntity> notifications;
  NotificationsLoaded({required this.notifications});
}

final class NotificationsError extends NotificationsState {
  final Failure failure;
  NotificationsError({required this.failure});
}
