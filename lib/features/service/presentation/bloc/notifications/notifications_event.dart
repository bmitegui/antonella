part of 'notifications_bloc.dart';

sealed class NotificationsEvent {
  const NotificationsEvent();
}

final class NotificationsInitialEvent extends NotificationsEvent {}

final class GetNotificationsEvent extends NotificationsEvent {
  GetNotificationsEvent();
}
