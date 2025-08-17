import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/data/models/service_model.dart';
import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/user/domain/entities/entities.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel(
      {required super.id,
      required super.orderId,
      required super.serviceId,
      required super.day,
      required super.startTime,
      required super.endTime,
      required super.status,
      required super.basePrice,
      required super.serviceEntity,
      required super.employees});

  factory AppointmentModel.fromJson(Map<String, dynamic> json,
      ServiceModel serviceModel, List<UserEntity> employees) {
    return AppointmentModel(
        id: json['id'],
        orderId: json['order_id'],
        serviceId: json['service_id'],
        day: json['date_info']['day'],
        startTime: json['date_info']['start_time'],
        endTime: json['date_info']['end_time'],
        status: stringToProgressStatus(json['status']),
        basePrice: json['base_price']?.toDouble() ?? 0.0,
        serviceEntity: serviceModel,
        employees: employees);
  }
}
