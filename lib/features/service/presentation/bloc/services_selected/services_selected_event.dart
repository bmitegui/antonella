part of 'services_selected_bloc.dart';

sealed class ServicesSelectedEvent {
  const ServicesSelectedEvent();
}

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
