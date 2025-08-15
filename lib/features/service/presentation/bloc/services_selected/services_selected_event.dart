part of 'services_selected_bloc.dart';

sealed class ServicesSelectedEvent {
  const ServicesSelectedEvent();
}

// -------------------- Servicios --------------------
final class ServicesSelectedInitialEvent extends ServicesSelectedEvent {}

final class AddServiceEvent extends ServicesSelectedEvent {
  final ServiceEntity service;
  AddServiceEvent({required this.service});
}

final class DeleteServiceEvent extends ServicesSelectedEvent {
  final ServiceEntity service;
  DeleteServiceEvent({required this.service});
}

final class SelectTimeEvent extends ServicesSelectedEvent {
  final String? timeSelected;
  SelectTimeEvent({required this.timeSelected});
}

final class SelectDateTimeEvent extends ServicesSelectedEvent {
  final DateTime? dateSelected;
  SelectDateTimeEvent({required this.dateSelected});
}

final class SelectEmployeeEvent extends ServicesSelectedEvent {
  final String serviceId;
  final String employeeId;
  SelectEmployeeEvent({required this.serviceId, required this.employeeId});
}

final class ClearServicesSelectedEvent extends ServicesSelectedEvent {}

// -------------------- Productos --------------------
final class AddProductEvent extends ServicesSelectedEvent {
  final ProductEntity product;
  final int cant;
  AddProductEvent({required this.product, required this.cant});
}

final class UpdateProductQuantityEvent extends ServicesSelectedEvent {
  final ProductEntity product;
  final int newQuantity;

  UpdateProductQuantityEvent({
    required this.product,
    required this.newQuantity,
  });
}

final class DeleteProductEvent extends ServicesSelectedEvent {
  final ProductEntity product;
  DeleteProductEvent({required this.product});
}

final class ClearProductSelectedEvent extends ServicesSelectedEvent {}
