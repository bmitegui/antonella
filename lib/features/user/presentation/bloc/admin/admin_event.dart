part of 'admin_bloc.dart';

sealed class AdminEvent {
  const AdminEvent();
}

final class AdminInitialEvent extends AdminEvent {}

final class GetAdminEvent extends AdminEvent {}
