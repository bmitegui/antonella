part of 'orders_bloc.dart';

sealed class OrdersEvent {
  const OrdersEvent();
}

final class OrdersInitialEvent extends OrdersEvent {}

final class GetOrdersEvent extends OrdersEvent {
  final String id;
  GetOrdersEvent({required this.id});
}
