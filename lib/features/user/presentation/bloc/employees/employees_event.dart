part of 'employees_bloc.dart';

sealed class EmployeesEvent {
  const EmployeesEvent();
}

final class EmployeesInitialEvent extends EmployeesEvent {}

final class GetEmployeesEvent extends EmployeesEvent {
  final ServiceType serviceType;
  GetEmployeesEvent({required this.serviceType});
}
