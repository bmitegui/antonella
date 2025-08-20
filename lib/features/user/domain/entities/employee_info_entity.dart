import 'package:equatable/equatable.dart';

class EmployeeInfoEntity extends Equatable {
  final String employeeId;
  final double totalFacturado;
  final double totalPagado;
  final double totalPorPagar;
  final double restante;
  final int numClientes;

  const EmployeeInfoEntity(
      {required this.employeeId,
      required this.totalFacturado,
      required this.totalPagado,
      required this.totalPorPagar,
      required this.restante,
      required this.numClientes});

  @override
  List<Object?> get props => [employeeId];
}
