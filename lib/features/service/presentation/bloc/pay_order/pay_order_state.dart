part of 'pay_order_bloc.dart';

sealed class PayOrderState {
  const PayOrderState();
}

final class PayOrderInitial extends PayOrderState {}

final class PayOrderLoading extends PayOrderState {}

final class PayOrderLoaded extends PayOrderState {}

final class PayOrderError extends PayOrderState {
  final Failure failure;
  PayOrderError({required this.failure});
}
