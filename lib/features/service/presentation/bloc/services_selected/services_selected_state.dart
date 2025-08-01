part of 'services_selected_bloc.dart';

sealed class ServicesSelectedState {
  const ServicesSelectedState();
}

final class ServicesSelectedLoading extends ServicesSelectedState {}

final class ServicesSelectedLoaded extends ServicesSelectedState {
  final List<ServiceEntity> services;
  final DateTime? dateSelected;
  final String? timeSelected;
  final Map<String, String>? employeeIds;
  ServicesSelectedLoaded(
      {required this.services,
      required this.dateSelected,
      required this.timeSelected,
      required this.employeeIds});
  ServicesSelectedLoaded copyWith(
      {List<ServiceEntity>? services,
      DateTime? dateSelected,
      String? timeSelected,
      Map<String, String>? employeeIds}) {
    return ServicesSelectedLoaded(
        services: services ?? this.services,
        dateSelected: dateSelected ?? this.dateSelected,
        timeSelected: timeSelected ?? this.timeSelected,
        employeeIds: employeeIds ?? this.employeeIds);
  }

  String getSummedPriceRange() {
    if (services.isEmpty) {
      return '-';
    }

    double totalMinPrice =
        services.fold(0.0, (sum, service) => sum + service.minPrice);
    double totalMaxPrice =
        services.fold(0.0, (sum, service) => sum + service.maxPrice);

    return '\$${totalMinPrice.toStringAsFixed(2)} - \$${totalMaxPrice.toStringAsFixed(2)}';
  }
}

final class ServicesSelectedError extends ServicesSelectedState {
  final Failure failure;
  ServicesSelectedError({required this.failure});
}
