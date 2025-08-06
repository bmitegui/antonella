part of 'service_bloc.dart';

sealed class ServiceEvent {
  const ServiceEvent();
}

final class ServiceInitialEvent extends ServiceEvent {}

final class GetServicesEvent extends ServiceEvent {
  final ServiceType? serviceType;
  final String? name;
  GetServicesEvent({this.serviceType, this.name});
}
