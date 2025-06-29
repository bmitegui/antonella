import 'package:antonella/features/service/domain/entities/appointment_entity.dart';
import 'package:antonella/features/user/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

enum OrderStatus { confirmado, noConfirmado }

enum ClientStatus {confirmado, noConfirmado}

enum ProgressStatus { pendiente, enProgreso, finalizado }

enum PaymentStatus { pendiente, pagado }

enum PaymentType { efectivo, tarjeta }

class OrderEntity extends Equatable {
  final String id;
  final String clientId;
  final OrderStatus orderStatus;
  final ClientStatus clientStatus;
  final ProgressStatus progressStatus;
  final PaymentStatus paymentStatus;
  final PaymentType paymentType;
  final List<AppointmentEntity> appointments;
  final UserEntity userEntity;

  const OrderEntity(
      {required this.id,
      required this.clientId,
      required this.orderStatus,
      required this.clientStatus,
      required this.progressStatus,
      required this.paymentStatus,
      required this.paymentType,
      required this.appointments,
      required this.userEntity});

  @override
  List<Object?> get props => [id];
}
