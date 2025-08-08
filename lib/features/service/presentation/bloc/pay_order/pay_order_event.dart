part of 'pay_order_bloc.dart';

sealed class PayOrderEvent {
  const PayOrderEvent();
}

final class PayOrderInitialEvent extends PayOrderEvent {}

final class PagarOrdenEvent extends PayOrderEvent {
  final String orderId;
  final PaymentType paymentType;
  PagarOrdenEvent({required this.orderId, required this.paymentType});
}

class PagarVariasOrdenesEvent extends PayOrderEvent {
  final List<OrderEntity> orderIds;
  final PaymentType paymentType;

  PagarVariasOrdenesEvent({required this.orderIds, required this.paymentType});
}