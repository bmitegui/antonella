part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServicesLoaded extends ServiceState {
  final List<ServiceEntity> services;
  ServicesLoaded({required this.services});
}

final class ServiceError extends ServiceState {
  final String message;
  ServiceError({required this.message});
}
