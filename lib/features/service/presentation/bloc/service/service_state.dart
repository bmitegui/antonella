part of 'service_bloc.dart';

sealed class ServiceState {
  const ServiceState();
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServicesLoaded extends ServiceState {
  final ListServicesEntity listServices;
  final ServiceType serviceType;
  final bool isFiltered;
  ServicesLoaded(
      {required this.listServices,
      this.serviceType = ServiceType.all,
      this.isFiltered = false});

  Map<String, List<ServiceEntity>> getDataBySubCategories() {
    Map<String, List<ServiceEntity>> data = {};

    // Paso 1: agrupar
    for (var service in listServices.services) {
      data.putIfAbsent(service.subtype, () => []);
      data[service.subtype]!.add(service);
    }

    // Paso 2: definir orden deseado
    final order = [
      'TRATAMIENTOS',
      'COLOR',
      'CORTES',
      'MANICURA',
      'PEDICURA',
      'EXTENSIONES',
      'ESMALTADO',
      'CORPORAL',
      'SPA',
      'MASAJE'
    ];

    // Paso 3: ordenar según el índice en `order`
    final sortedEntries = data.entries.toList()
      ..sort((a, b) {
        final indexA = order.indexOf(a.key.toUpperCase());
        final indexB = order.indexOf(b.key.toUpperCase());

        // Si no está en el orden, lo mando al final
        final safeA = indexA == -1 ? order.length : indexA;
        final safeB = indexB == -1 ? order.length : indexB;

        return safeA.compareTo(safeB);
      });

    // Paso 4: reconstruir manteniendo orden
    return Map.fromEntries(sortedEntries);
  }
}

final class ServicesError extends ServiceState {
  final Failure failure;
  ServicesError({required this.failure});
}
