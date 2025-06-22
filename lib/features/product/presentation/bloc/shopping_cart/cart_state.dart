part of 'cart_bloc.dart';


sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {}

final class CartError extends CartState {
  final String message;
  CartError({required this.message});
}