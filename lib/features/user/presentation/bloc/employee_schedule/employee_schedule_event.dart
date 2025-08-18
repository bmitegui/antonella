part of 'employee_schedule_bloc.dart';

sealed class EmployeeScheduleEvent {
  const EmployeeScheduleEvent();
}

final class EmployeeScheduleInitialEvent extends EmployeeScheduleEvent {}

final class GetEmployeeScheduleEvent extends EmployeeScheduleEvent {
  final String employeeId;
  GetEmployeeScheduleEvent({required this.employeeId});
}
