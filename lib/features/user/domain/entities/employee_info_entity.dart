import 'package:equatable/equatable.dart';

class EmployeeInfoEntity extends Equatable {
  final String employeeId;
  final double facturado;
  final double pagado;
  final int numClientes;

  const EmployeeInfoEntity(
      {required this.employeeId,
      required this.facturado,
      required this.pagado,
      required this.numClientes});

  @override
  List<Object?> get props => [employeeId];
}
