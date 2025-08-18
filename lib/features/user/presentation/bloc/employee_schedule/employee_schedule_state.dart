part of 'employee_schedule_bloc.dart';

sealed class EmployeeScheduleState {
  const EmployeeScheduleState();
}

final class EmployeeScheduleInitial extends EmployeeScheduleState {}

final class EmployeeScheduleLoading extends EmployeeScheduleState {}

final class EmployeeScheduleLoaded extends EmployeeScheduleState {
  final List<ScheduleEntity> dates;
  EmployeeScheduleLoaded({required this.dates});
}

final class EmployeeScheduleError extends EmployeeScheduleState {
  final Failure failure;
  EmployeeScheduleError({required this.failure});
}
