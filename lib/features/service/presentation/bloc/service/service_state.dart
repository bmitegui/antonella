part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServicesLoaded extends ServiceState {
  final ListServicesEntity listServices;
  final ServiceType serviceType;
  ServicesLoaded(
      {required this.listServices, this.serviceType = ServiceType.all});

  Map<String, List<ServiceEntity>> getDataBySubCategories() {
    Map<String, List<ServiceEntity>> data = {};
    for (var service in listServices.services) {
      if (!data.containsKey(service.subtype)) {
        data[service.subtype] = [service];
      } else {
        data[service.subtype]!.add(service);
      }
    }
    return data;
  }
}

final class ServicesError extends ServiceState {
  final Failure failure;
  ServicesError({required this.failure});
}
