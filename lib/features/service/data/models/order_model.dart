import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/service/data/models/appointment_model.dart';
import 'package:antonella/features/service/domain/entities/order_entity.dart';
import 'package:antonella/features/user/data/models/user_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel(
      {required super.id,
      required super.clientId,
      required super.orderStatus,
      required super.clientStatus,
      required super.progressStatus,
      required super.paymentStatus,
      required super.paymentType,
      required super.appointments,
      required super.userEntity,
      required super.iva});

  factory OrderModel.fromJson(Map<String, dynamic> json,
      List<AppointmentModel> appointments, UserModel userModel) {
    return OrderModel(
        id: json['id'],
        clientId: json['client_id'],
        orderStatus: stringToOrderStatus(json['status']['status']),
        clientStatus: stringToClientStatus(json['status']['client_confirmed']),
        progressStatus:
            stringToProgressStatus(json['status']['progress_status']),
        paymentStatus: stringToPaymentStatus(json['status']['payment_status']),
        paymentType: stringToPaymentType(json['status']['payment_type']),
        appointments: appointments,
        userEntity: userModel,
        iva: json['iva']);
  }
}
