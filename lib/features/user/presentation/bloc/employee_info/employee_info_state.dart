part of 'employee_info_bloc.dart';

sealed class EmployeeInfoState {
  const EmployeeInfoState();
}

final class EmployeeInfoInitial extends EmployeeInfoState {}

final class EmployeeInfoLoading extends EmployeeInfoState {}

final class EmployeeInfoLoaded extends EmployeeInfoState {
  final EmployeeInfoEntity employeeInfoEntity;
  EmployeeInfoLoaded({required this.employeeInfoEntity});
}

final class EmployeeInfoError extends EmployeeInfoState {
  final Failure failure;
  EmployeeInfoError({required this.failure});
}
