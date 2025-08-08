part of 'promotion_cart_bloc.dart';

sealed class PromotionCartState {
  const PromotionCartState();
}

class PromotionCartInitial extends PromotionCartState {}

final class PromotionLoading extends PromotionCartState {}


class PromotionCartLoaded extends PromotionCartState {
  final List<PromotionEntity> cartPromotions;
  PromotionCartLoaded({required this.cartPromotions});
}

final class PromotionError extends PromotionCartState {
  final Failure failure;
  PromotionError({required this.failure});
}

