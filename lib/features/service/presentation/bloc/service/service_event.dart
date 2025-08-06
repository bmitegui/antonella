part of 'service_bloc.dart';

sealed class ServiceEvent {
  const ServiceEvent();
}

final class ServiceInitialEvent extends ServiceEvent {}

final class GetServicesEvent extends ServiceEvent {
  final ServiceType? serviceType;
  GetServicesEvent({this.serviceType});
}

final class GetServicesByNameEvent extends ServiceEvent {
  final String name;

  GetServicesByNameEvent({required this.name});
  
}
