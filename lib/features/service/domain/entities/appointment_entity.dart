import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String orderId;
  final String serviceId;
  final String day;
  final String startTime;
  final String? endTime;
  final ProgressStatus status;
  final double? basePrice;
  final ServiceEntity serviceEntity;
  final UserEntity? userEntity;
  final List<UserEntity> employees;

  const AppointmentEntity(
      {required this.id,
      required this.orderId,
      required this.serviceId,
      required this.day,
      required this.startTime,
      required this.endTime,
      required this.status,
      required this.basePrice,
      required this.serviceEntity,
      this.userEntity,
      required this.employees});

  @override
  List<Object?> get props => [id];

  AppointmentEntity copyWith({
    String? id,
    String? orderId,
    String? serviceId,
    String? day,
    String? startTime,
    String? endTime,
    ProgressStatus? status,
    double? basePrice,
    ServiceEntity? serviceEntity,
    UserEntity? userEntity,
    List<UserEntity>? employees,
  }) {
    return AppointmentEntity(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        serviceId: serviceId ?? this.serviceId,
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status,
        basePrice: basePrice ?? this.basePrice,
        serviceEntity: serviceEntity ?? this.serviceEntity,
        userEntity: userEntity ?? this.userEntity,
        employees: employees ?? this.employees);
  }
}
