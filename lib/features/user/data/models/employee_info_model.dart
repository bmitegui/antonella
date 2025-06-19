import 'package:antonella/features/user/domain/entities/employee_info_entity.dart';

class EmployeeInfoModel extends EmployeeInfoEntity {
  const EmployeeInfoModel(
      {required super.employeeId,
      required super.facturado,
      required super.pagado,
      required super.numClientes});

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) {
    final employeeId = json['employee_id'];
    final facturado = json['total_facturado'];
    final pagado = json['total_pagado'];
    final numClientes = (json['service_items'] as List).length;

    return EmployeeInfoModel(
        employeeId: employeeId,
        facturado: facturado,
        pagado: pagado,
        numClientes: numClientes);
  }
}
