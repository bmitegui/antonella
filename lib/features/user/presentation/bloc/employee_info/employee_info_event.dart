part of 'employee_info_bloc.dart';

sealed class EmployeeInfoEvent {
  const EmployeeInfoEvent();
}

final class EmployeeInfoInitialEvent extends EmployeeInfoEvent {}

final class GetEmployeeInfoEvent extends EmployeeInfoEvent {
  final String employeeId;
  final String startDate;
  final String endDate;

  GetEmployeeInfoEvent(
      {required this.employeeId,
      required this.startDate,
      required this.endDate});
}
