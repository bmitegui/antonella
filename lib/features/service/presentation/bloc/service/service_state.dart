part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServicesLoaded extends ServiceState {
  final ListServicesEntity listServices;
  ServicesLoaded({required this.listServices});

  Map<String, List<ServiceEntity>> getDataBySubCategories() {
    Map<String, List<ServiceEntity>> data = {};
    for (var service in listServices.services) {
      if (!data.containsKey(service.subCategory)) {
        data[service.subCategory] = [service];
      } else {
        data[service.subCategory]!.add(service);
      }
    }
    return data;
  }
}

final class ServicesError extends ServiceState {
  final String message;
  ServicesError({required this.message});
}
