part of 'service_bloc.dart';

sealed class ServiceEvent {
  const ServiceEvent();
}

final class ServiceInitialEvent extends ServiceEvent {}

final class GetServicesEvent extends ServiceEvent {}
