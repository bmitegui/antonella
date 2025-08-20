import 'package:antonella/features/user/domain/entities/employee_info_entity.dart';

class EmployeeInfoModel extends EmployeeInfoEntity {
  const EmployeeInfoModel(
      {required super.employeeId,
      required super.totalFacturado,
      required super.totalPagado,
      required super.totalPorPagar,
      required super.restante,
      required super.numClientes});

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) {
    final employeeId = json['employee_id'];
    final totalFacturado = json['total_facturado'];
    final totalPagado = json['total_pagado'];
    final totalPorPagar = json['total_por_pagar'];
    final restante = json['restante'];
    final numClientes = (json['service_items'] as List).length;

    return EmployeeInfoModel(
        employeeId: employeeId,
        totalFacturado: totalFacturado,
        totalPagado: totalPagado,
        totalPorPagar: totalPorPagar,
        restante: restante,
        numClientes: numClientes);
  }
}
