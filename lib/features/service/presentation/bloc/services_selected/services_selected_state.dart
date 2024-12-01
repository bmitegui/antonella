part of 'services_selected_bloc.dart';

sealed class ServicesSelectedState {
  const ServicesSelectedState();
}

final class ServicesSelectedLoading extends ServicesSelectedState {}

final class ServicesSelectedLoaded extends ServicesSelectedState {
  final List<ServiceEntity> listServicesSelected;
  final DateTime? dateSelected;
  final String? timeSelected;
  ServicesSelectedLoaded(
      {required this.listServicesSelected,
      required this.dateSelected,
      required this.timeSelected});

  String getSummedPriceRange() {
    if (listServicesSelected.isEmpty) {
      return '-';
    }

    double totalMinPrice = listServicesSelected.fold(
        0.0, (sum, service) => sum + service.minPrice);
    double totalMaxPrice = listServicesSelected.fold(
        0.0, (sum, service) => sum + service.maxPrice);

    return '\$${totalMinPrice.toStringAsFixed(2)} - \$${totalMaxPrice.toStringAsFixed(2)}';
  }
}

final class ServicesSelectedError extends ServicesSelectedState {
  final String message;
  ServicesSelectedError({required this.message});
}
