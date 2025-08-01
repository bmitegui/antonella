part of 'employees_bloc.dart';

sealed class EmployeesState {
  const EmployeesState();
}

final class EmployeesInitial extends EmployeesState {}

final class EmployeesLoading extends EmployeesState {}

final class EmployeesLoaded extends EmployeesState {
  final List<UserEntity> listEmployees;
  EmployeesLoaded({required this.listEmployees});
}

final class EmployeesError extends EmployeesState {
  final Failure failure;
  EmployeesError({required this.failure});
}
