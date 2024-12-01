part of 'services_selected_bloc.dart';

sealed class ServicesSelectedEvent {
  const ServicesSelectedEvent();
}

final class ServicesSelectedInitialEvent extends ServicesSelectedEvent {}

final class AddServiceSelectedEvent extends ServicesSelectedEvent {
  final ServiceEntity serviceEntitySelected;
  final List<ServiceEntity> listServicesSelected;
  final DateTime? dateSelected;
  final String? timeSelected;
  AddServiceSelectedEvent(
      {required this.serviceEntitySelected,
      required this.listServicesSelected,
      required this.dateSelected,
      required this.timeSelected});
}

final class DeleteServiceSelectedEvent extends ServicesSelectedEvent {
  final ServiceEntity serviceEntitySelected;
  final List<ServiceEntity> listServicesSelected;
  final DateTime? dateSelected;
  final String? timeSelected;
  DeleteServiceSelectedEvent(
      {required this.serviceEntitySelected,
      required this.listServicesSelected,
      required this.dateSelected,
      required this.timeSelected});
}

final class SelectTimeEvent extends ServicesSelectedEvent {
  final List<ServiceEntity> listServicesSelected;
  final DateTime? dateSelected;
  final String? timeSelected;
  SelectTimeEvent(
      {required this.listServicesSelected,
      required this.dateSelected,
      required this.timeSelected});
}

final class SelectDateTimeEvent extends ServicesSelectedEvent {
  final List<ServiceEntity> listServicesSelected;
  final DateTime? dateSelected;
  final String? timeSelected;
  SelectDateTimeEvent(
      {required this.listServicesSelected,
      required this.dateSelected,
      required this.timeSelected});
}
