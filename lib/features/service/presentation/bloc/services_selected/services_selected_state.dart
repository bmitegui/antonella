part of 'services_selected_bloc.dart';

sealed class ServicesSelectedState {
  const ServicesSelectedState();
}

final class ServicesSelectedLoading extends ServicesSelectedState {}

final class ServicesSelectedLoaded extends ServicesSelectedState {
  final List<ServiceEntity> services;
  final List<ProductEntity> products;
  final DateTime? dateSelected;
  final String? timeSelected;
  final Map<String, String>? employeeIds;

  const ServicesSelectedLoaded({
    required this.services,
    required this.products,
    required this.dateSelected,
    required this.timeSelected,
    required this.employeeIds,
  });

  ServicesSelectedLoaded copyWith({
    List<ServiceEntity>? services,
    List<ProductEntity>? products,
    DateTime? dateSelected,
    String? timeSelected,
    Map<String, String>? employeeIds,
  }) {
    return ServicesSelectedLoaded(
      services: services ?? this.services,
      products: products ?? this.products,
      dateSelected: dateSelected ?? this.dateSelected,
      timeSelected: timeSelected ?? this.timeSelected,
      employeeIds: employeeIds ?? this.employeeIds,
    );
  }

  String getSummedPriceRange() {
    if (services.isEmpty && products.isEmpty) {
      return '-';
    }

    final double totalMinPrice =
        services.fold(0.0, (sum, service) => sum + service.minPrice) +
            getTotalProductsPrice(); // agregamos productos
    final double totalMaxPrice = services.fold(
            0.0, (sum, service) => sum + service.maxPrice) +
        getTotalProductsPrice(); // productos se consideran igual que precio fijo

    // Si min y max son iguales, mostrar solo uno
    if (totalMinPrice == totalMaxPrice) {
      return '\$${totalMinPrice.toStringAsFixed(2)}';
    }

    return '\$${totalMinPrice.toStringAsFixed(2)} - \$${totalMaxPrice.toStringAsFixed(2)}';
  }

  double getTotalProductsPrice() {
    if (products.isEmpty) {
      return 0.0;
    }
    return products.fold(0.0, (sum, product) => sum + product.price);
  }

  double getTotalCombinedPriceMin() {
    return services.fold(0.0, (sum, service) => sum + service.minPrice) +
        getTotalProductsPrice();
  }

  double getTotalCombinedPriceMax() {
    return services.fold(0.0, (sum, service) => sum + service.maxPrice) +
        getTotalProductsPrice();
  }
}

final class ServicesSelectedError extends ServicesSelectedState {
  final Failure failure;
  const ServicesSelectedError({required this.failure});
}
