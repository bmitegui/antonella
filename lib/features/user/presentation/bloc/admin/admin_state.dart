part of 'admin_bloc.dart';

sealed class AdminState {
  const AdminState();
}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final UserEntity userEntity;
  AdminLoaded({required this.userEntity});
}

final class AdminError extends AdminState {
  final Failure failure;
  AdminError({required this.failure});
}
