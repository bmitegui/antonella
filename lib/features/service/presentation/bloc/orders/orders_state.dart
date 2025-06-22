part of 'orders_bloc.dart';

sealed class OrdersState {
  const OrdersState();
}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;
  OrdersLoaded({required this.orders});
}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError({required this.message});
}
